folder$ = "/Users/katouryuusei/Downloads/analysis"
strings = Create Strings as file list: "list", folder$ + "/*.wav"
numberOfFiles = Get number of strings
for ifile to numberOfFiles
    selectObject: strings
    fileName$ = Get string: ifile
    Read from file: folder$ + "/" + fileName$
endfor