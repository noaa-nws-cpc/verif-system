Data Requirements
=================

Data files must be in text format. Here are some conventions to follow.

File name
---------

Data files can be named however you'd like, but they need a few pieces of information in the name:

1. Variable (temp or precip)
2. Model/tool name (eg. gfs-00z, kleins, ecca, etc. - attach the cycle if the source is a model with a cycle)
3. Lead (eg. 6-10day, 02m_03m [seasonal - <lead>_<window>], etc.)
4. Spatial type (eg. stn, gridded, cd, etc.)

Also, it's best to use a `.txt` extension.

File contents
-------------

Here are the minimum requirements for the data files (you can have more columns if you want, there's a lookup table for each tool that specifies column names to read in, so the others are ignored).

### Observations

- id column (can be a number or a string - for gridded, use the grid point X/Y value, but make sure it's zero-padded [eg. 0101, 0102, etc.])
- category column

For example, here's an excerpt from an observation data file:

```
id      category
0101           2
0102           2
0103           3
0104           2
0105           2
0106           2
0107           2
0108           3
0109           2
...
```

### Forecasts

- id column (can be a number or a string - for gridded, use the grid point X/Y value, but make sure it's zero-padded [eg. 0101, 0102, etc.])
- below column (number between 0 and 1)
- near column (number between 0 and 1)
- above column (number between 0 and 1)

For example, here's an excerpt from an forecast data file:

```
id      below    near   above
69002   0.393   0.284   0.324
69007   0.726   0.204   0.070
69008   0.393   0.284   0.324
69012   0.052   0.087   0.862
69013   0.408   0.303   0.288
69014   0.703   0.171   0.125
69016   0.703   0.171   0.125
69017   0.500   0.260   0.240
69019   0.388   0.312   0.300
...
```
