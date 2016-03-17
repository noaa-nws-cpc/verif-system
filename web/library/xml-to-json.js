// The MIT License (MIT)
//
// Copyright (c) 2015 William Summers & MetaTribal LLC
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

var xmlToJSON=function(){this.version="1.3";var e={mergeCDATA:!0,grokAttr:!0,grokText:!0,normalize:!0,xmlns:!0,namespaceKey:"_ns",textKey:"_text",valueKey:"_value",attrKey:"_attr",cdataKey:"_cdata",attrsAsObject:!0,stripAttrPrefix:!0,stripElemPrefix:!0,childrenAsArray:!0},t=new RegExp(/(?!xmlns)^.*:/),r=new RegExp(/^\s+|\s+$/g);return this.grokType=function(e){return/^\s*$/.test(e)?null:/^(?:true|false)$/i.test(e)?"true"===e.toLowerCase():isFinite(e)?parseFloat(e):e},this.parseString=function(e,t){return this.parseXML(this.stringToXML(e),t)},this.parseXML=function(a,n){for(var s in n)e[s]=n[s];var l={},i=0,o="";if(e.xmlns&&a.namespaceURI&&(l[e.namespaceKey]=a.namespaceURI),a.attributes&&a.attributes.length>0){var c={};for(i;i<a.attributes.length;i++){var u=a.attributes.item(i);m={};var p="";p=e.stripAttrPrefix?u.name.replace(t,""):u.name,e.grokAttr?m[e.valueKey]=this.grokType(u.value.replace(r,"")):m[e.valueKey]=u.value.replace(r,""),e.xmlns&&u.namespaceURI&&(m[e.namespaceKey]=u.namespaceURI),e.attrsAsObject?c[p]=m:l[e.attrKey+p]=m}e.attrsAsObject&&(l[e.attrKey]=c)}if(a.hasChildNodes())for(var y,d,m,h=0;h<a.childNodes.length;h++)y=a.childNodes.item(h),4===y.nodeType?e.mergeCDATA?o+=y.nodeValue:l.hasOwnProperty(e.cdataKey)?(l[e.cdataKey].constructor!==Array&&(l[e.cdataKey]=[l[e.cdataKey]]),l[e.cdataKey].push(y.nodeValue)):e.childrenAsArray?(l[e.cdataKey]=[],l[e.cdataKey].push(y.nodeValue)):l[e.cdataKey]=y.nodeValue:3===y.nodeType?o+=y.nodeValue:1===y.nodeType&&(0===i&&(l={}),d=e.stripElemPrefix?y.nodeName.replace(t,""):y.nodeName,m=xmlToJSON.parseXML(y),l.hasOwnProperty(d)?(l[d].constructor!==Array&&(l[d]=[l[d]]),l[d].push(m)):(e.childrenAsArray?(l[d]=[],l[d].push(m)):l[d]=m,i++));else o||(e.childrenAsArray?(l[e.textKey]=[],l[e.textKey].push(null)):l[e.textKey]=null);if(o)if(e.grokText){var x=this.grokType(o.replace(r,""));null!==x&&void 0!==x&&(l[e.textKey]=x)}else e.normalize?l[e.textKey]=o.replace(r,"").replace(/\s+/g," "):l[e.textKey]=o.replace(r,"");return l},this.xmlToString=function(e){try{var t=e.xml?e.xml:(new XMLSerializer).serializeToString(e);return t}catch(r){return null}},this.stringToXML=function(e){try{var t=null;if(window.DOMParser){var r=new DOMParser;return t=r.parseFromString(e,"text/xml")}return t=new ActiveXObject("Microsoft.XMLDOM"),t.async=!1,t.loadXML(e),t}catch(a){return null}},this}.call({});"undefined"!=typeof module&&null!==module&&module.exports?module.exports=xmlToJSON:"function"==typeof define&&define.amd&&define(function(){return xmlToJSON});
