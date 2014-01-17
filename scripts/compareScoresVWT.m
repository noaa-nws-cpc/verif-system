%function [] = compareScores(preferenceFile)
%Compare Verification Scores From Two Different Systems
%
clear
preferenceFile = '../input/preferences_compareScoresVWT_NOHADS.xml';
%--------------------------------------------------------------------------
% Check for the VERIF_HOME environment variable. This must be set before
% the script will run.
global VERIF_HOME;
VERIF_HOME = getenv('VERIF_HOME');
if isempty(VERIF_HOME)
    error('The VERIF_HOME environment variable must be set before running.');
end

%--------------------------------------------------------------------------
% Add the directory containing custom Matlab functions to the search pat#h
%
addpath([VERIF_HOME '/library/matlab']);

%--------------------------------------------------------------------------
% Read in preferences from an XML file
%
% Use the custom xml2struct() function to convert the xml file into a
% Matlab structure. Put this in a temporary variable because xml2struct
% will give us the XML root element (preferences), but we want a variable
% that starts with the 'file' elements. For example
% preferences = xml2struct(preferenceFile) yields
% preferences.preferences.file[1|2], while I want preferences.file[1|2].
temp = xml2struct(preferenceFile);
% Remove the top level from the structure
preferences = temp.preferences;
% clear other temporary variables
clear preferenceFile temp;
%--------------------------------------------------------------------------
% Loop over files, processing one at a time
%
% Get the preferences
temp = fieldnames(preferences);
% Get preferences only for tags beginning with 'file'
filePreferences = temp(regexpcell(temp, '^file'));
%
% Loop over all files, and replace that portion of the 'preferences'
% structure with a variable 'file'.
for file = filePreferences'
    %----------------------------------------------------------------------
    % Read in the file
    %
    % Replace any occurrence of '$VERIF_HOME' in the filename with the
    % value of VERIF_HOME
    preferences.(char(file)).name.Text = regexprep(preferences.(char(file)).name.Text, '\$VERIF_HOME', VERIF_HOME);
    % Use fopen to get a file handle
    [fid message] = fopen(preferences.(char(file)).name.Text);
    % See if it opened successfully
    if (fid == -1)
        error(['Cannot open ' preferences.(char(file)).name.Text ': ' message]);
    end
    %----------------------------------------------------------------------
    % Obtain and format the appropriate columns
    %
    % Get the header line
    header = textscan(fid, '%s', str2num(preferences.(char(file)).columnCount.Text), 'CommentStyle', '#');
    % Get index of the date and score columns
    index.date  = getStringIndex(preferences.(char(file)).dateColumnName.Text,header{1});
    index.score = getStringIndex(preferences.(char(file)).scoreColumnName.Text,header{1});
    % Create a format string for columnCount number of strings
    format = repmat('%s ',1,str2num(preferences.(char(file)).columnCount.Text));
    
    %----------------------------------------------------------------------
    % Read in the data
    %
    % Use the textscan() method to read in all the data
    tempData = textscan(fid, format);
    % Get needed columns, converting to the appropriate formate
    data.(char(file)).date  = datenum(tempData{index.date},preferences.(char(file)).dateColumnFormat.Text); % Serial date
    data.(char(file)).score = cellfun(@str2num,tempData{index.score}); % Number
    % Close the file
    fclose(fid);
    % Replace all missing values with NaN
    if (strcmp(preferences.(char(file)).missingValue.Text,'NaN'))
%         Don't do anything, it's already NaN
    else
       data.(char(file)).score(data.(char(file)).score == str2num(preferences.(char(file)).missingValue.Text)) = NaN;
    end
    %----------------------------------------------------------------------
    % Shift the data by the date offset (if needed). For example, Scott's
    % files use the 1st valid month, whereas we use the center valid month.
    %
    % try block for accessing the dateOffset preference. If there is no
    % value for this preference, an exception will be caught.
    try
        % Use regex to get the tokens. In the XML, the dateOffset is
        % specified by a number, immediately followed by a character. For
        % example, -01m means the data is dated 1 month earlier than it 
        % should be, and 02d means the data is dated 2 days later than it
        % should be.
        tokens = regexp(preferences.(char(file)).dateOffset.Text, '([-+]?\d+)([a-zA-Z]{1})', 'tokens');
        dateOffset = str2num(char(tokens{1}(1))); dateOffsetUnit = char(tokens{1}(2));
        % Shift the dates to remove the offset. The offset is subtracted from the
        % date array, so if the offset is -1m, then the date array actually gets a
        % month added to it. This is because an offset of -1m means the dates are 1
        % month earlier than they should be.
        if (strcmp(dateOffsetUnit,'m'))
            dateOffsetUnit = 'month';
        elseif (strcmp(dateOffsetUnit,'d'))
            dateOffsetUnit = 'day';
        end
        % Shift every date using the addtodate() function
        data.(char(file)).date = arrayfun(@(x) addtodate(x,-1*dateOffset, dateOffsetUnit), data.(char(file)).date);
    catch exception
    end
end
    
%--------------------------------------------------------------------------
% Find the intersection of the dates of both files and rewrite arrays
% so they align and have the same length
%
% Use Matlab's intersect() function to find the intersect
[~, index.file1, index.file2] = intersect(data.file1.date, data.file2.date);
% Take subset of the arrays where they all intersect
data.file1.date  = data.file1.date(index.file1);
data.file1.score = data.file1.score(index.file1);
data.file2.date  = data.file2.date(index.file2);
data.file2.score = data.file2.score(index.file2);

%--------------------------------------------------------------------------
% Generate a file to compare scores programmatically 
%
% Set the name of the output files
% outputFilePrefix = ['compareScoresVWT_' preferences.variable.Text '_' preferences.fcstType.Text '_' preferences.spatialType.Text '_' preferences.numDates.Text '_' preferences.scoreType.Text];
outputFilePrefix = preferences.outputFilePrefix.Text;
% Open the output file
fid = fopen(['../output/' outputFilePrefix '.txt'],'w');
% Print the header. After 'valid_date', the first name is the second one listed in the preference.xml file.
% The second name is the first one listed in the preference.xml file.
fprintf(fid, '# %s %6s %6s %6s\n','Valid_date',preferences.file1.dataName.Text,preferences.file2.dataName.Text,'Diff');
% Print each line of data
for i=1:length(data.file1.date)
    fprintf(fid, '  %s %6.1f %6.1f %6.1f\n', datestr(data.file1.date(i),'yyyy-mm-dd'), data.file1.score(i), data.file2.score(i), data.file2.score(i)-data.file1.score(i));
end
% Close the file
fclose(fid);

%--------------------------------------------------------------------------
% Generate a plot to compare scores visually
%
% Open a new plot
h = figure;
% Plot Scott's scores
subplot(3,1,[1,2]), hold on;
plot(data.file1.date, data.file1.score, 'k-', 'LineWidth',4);
% Plot VWT's scores
subplot(3,1,[1,2]), plot(data.file2.date, data.file2.score, 'r-', 'LineWidth',1);

% Set the X ticks to the first day of every month
temp = strcmp('01',cellstr(datestr(data.file1.date,'dd')));
xTicks = data.file1.date(temp==1);
% Get the tick labels for each tick
xTickLabels = cellstr(datestr(xTicks,'mm/dd/yyyy'));
% Set the X ticks and labels

% Set the X-axis to a date format
% datetick('x','mm/dd/yyyy')
set(gca,'XTick',xTicks);
set(gca,'XTickLabel',xTickLabels);
set(gca,'XMinorTick','on');
% Set the X limits
xlim([data.file1.date(1) data.file1.date(end)]);

%--------------------------------------------------------------------------
% Annotate plot
%
% set(gca, 'FontSize', 12);
% Title
title(['Verification System Benchmarking - ' preferences.variable.Text ' - ' preferences.fcstType.Text ' - ' preferences.spatialType.Text ' - ' preferences.scoreType.Text]);
% Axes
% xlabel('Year');
ylabel(preferences.scoreType.Text);
% Legend
% The first value is the second one listed in the preferences.xml input file, the second value is the first one listed in the file.
legend(preferences.file1.dataName.Text, preferences.file2.dataName.Text, 'Location', 'Northwest');
% Rotate the x tick labels
xticklabel_rotate([], 45, [], 'FontSize', 8);

%--------------------------------------------------------------------------
% Calculate statistics
%
diffArray = data.file1.score-data.file2.score;
% Mean difference
meanDiff = mean(diffArray(not(isnan(diffArray))));
% Mean absolute difference
meanAbsDiff = mean(abs(diffArray(not(isnan(diffArray)))));
corr = corrcoef(data.file1.score(not(isnan(data.file1.score) | isnan(data.file2.score))),data.file2.score(not(isnan(data.file1.score) | isnan(data.file2.score))));
% Maximum absolute difference
maxAbsDiff.value = max(abs(diffArray));
% Minimum absolute difference
minAbsDiff.value = min(abs(diffArray));
% If the max diff is 0, then the date array should be empty, since a max of
% zero means there isn't a day that the different occurred
if maxAbsDiff.value == 0 
    maxAbsDiff.date = [];
else
    maxAbsDiff.date = data.file1.date(abs(diffArray) == maxAbsDiff.value); % Date it occurred
end
if minAbsDiff.value == 0
    minAbsDiff.date = [];
else
    minAbsDiff.date = data.file1.date(abs(diffArray) == minAbsDiff.value); % Date it occurred
end
% Convert dates to cell
temp = cellstr(datestr(maxAbsDiff.date,'mm/dd/yyyy'));
temp2= cellstr(datestr(minAbsDiff.date,'mm/dd/yyyy'));
% String version of date(s)
maxAbsDiff.dateString = regexprep(sprintf('%s, ', temp{:}),',\s*$','');
minAbsDiff.dateString = regexprep(sprintf('%s, ', temp2{:}),',\s*$','');
% Any date with a difference
datesDifferent.date   = data.file1.date(data.file1.score ~= data.file2.score);
% Convert dates to cell
temp = cellstr(datestr(datesDifferent.date,'mm/yyyy'));
% String version of date(s)
datesDifferent.string = regexprep(sprintf('%s, ', temp{:}),',\s*$','');

%--------------------------------------------------------------------------
% Place textual information in the bottom portion of the plot
%
% Get the position of the bottom box
temp = subplot(3,1,3); textPosition = get(temp, 'Position'); delete(temp);
% Set up a string to go into the text box
textBoxString = {...
    [' '],...
    ['Mean diff: ' sprintf('%0.3f',meanDiff)],...
    ['Mean abs diff: ' sprintf('%0.3f',meanAbsDiff)],...
    ['Max abs diff: ' sprintf('%0.3f',maxAbsDiff.value)]...
    ['Min abs diff: ' sprintf('%0.3f',minAbsDiff.value)]...
    ['Correlation: ' sprintf('%0.3f',corr(2,1))]...
    ['Date(s) where max abs diffs occur: ' maxAbsDiff.dateString]...
    ['Date(s) where min abs diffs occur: ' minAbsDiff.dateString]...
};
annotation(gcf, 'TextBox', textPosition, 'FontSize', 8, 'String', textBoxString, 'FitBoxToText', 'off');
% Save PNG
saveas(gcf,['../output/' outputFilePrefix '.png']);
% Set properties that will result in a full page, landscape PDF
set(gcf,'PaperPositionMode','auto');
set(gcf,'PaperUnits','normalized');
set(gcf,'PaperOrientation','landscape');
set(gcf,'PaperPosition', [0 0 1 1]);
saveas(gcf,['../output/' outputFilePrefix '.pdf']);
close;




