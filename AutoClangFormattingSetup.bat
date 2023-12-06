start cmd /k "echo This script must be placed at the same level as the .git folder && npm install -g clang-format && Echo Generated the pre-commit file for auto formatting and copied it into .git/hooks/ folder. && Echo Generated the custom .clang-format file at the current folder for the auto formatting pre-commit"

@Echo Off
Set "out=.\.git\hooks"
(
 Echo #!/bin/bash
 Echo(
 Echo echo "running pre-commit clang-format at ./.git/hooks/pre-commit"
 Echo( 
 Echo # Get the path to clang-format
 Echo exe=$(which clang-format^)
 Echo( 
 Echo # Specify the path to the clang-format file
 Echo style=file:.clang-format
 Echo( 
 Echo # Check if clang-format is installed
 Echo if [ -n "$exe" ]; then
 Echo   # Set the field separator to newline
 Echo   IFS=$'\n'
 Echo( 
 Echo   # Loop through the files that are modified or added
 Echo   for line in $(git status -s^); do
 Echo     # Check if the file is added or modified
 Echo     if [[ $line == A* ^|^| $line == M* ]]; then
 Echo       # Check if the file extension is .cpp, .h, or .hpp
 Echo       if [[ $line == *.cpp ^|^| $line == *.h ^|^| $line == *.hpp ]]; then
 Echo         # Format the file with clang-format
 Echo 		   echo "[$line]" is being formatted using the clang-format style $style
 Echo         clang-format -style=$style -i $(pwd^)/${line:3}
 Echo         # Add the formatted file to the staging area
 Echo         git add $(pwd^)/${line:3}
 Echo       fi
 Echo     fi
 Echo   done
 Echo else
 Echo   # Print an error message if clang-format is not found
 Echo   echo "clang-format was not found"
 Echo fi
) > "%out%\pre-commit"

@Echo Off
Set "outDir=."
(
Echo StatementMacros: ['UPROPERTY', 'UFUNCTION', 'UCLASS', 'USTRUCT', 'UENUM', 'UINTERFACE', 'GENERATED_BODY']
Echo Language: Cpp
Echo BasedOnStyle: LLVMEcho 

Echo AccessModifierOffset: -4
Echo AlignAfterOpenBracket: DontAlign
Echo AlignConsecutiveDeclarations: true
Echo AlignEscapedNewlines: Left
Echo AlignOperands: DontAlign
Echo AlignTrailingComments: true
Echo AllowShortBlocksOnASingleLine: Empty
Echo AllowShortEnumsOnASingleLine: false
Echo AllowShortFunctionsOnASingleLine: Inline
Echo AllowShortLambdasOnASingleLine: All
Echo BraceWrapping:
Echo   AfterCaseLabel: true
Echo   AfterClass: true
Echo   AfterControlStatement: true
Echo   AfterEnum: true
Echo   AfterFunction: true
Echo   AfterNamespace: true
Echo   AfterObjCDeclaration: true
Echo   AfterStruct: true
Echo   AfterUnion: true
Echo   AfterExternBlock: true
Echo   BeforeCatch: true
Echo   BeforeElse: true
Echo   BeforeLambdaBody: false
Echo   BeforeWhile: true
Echo   IndentBraces: false
Echo BreakBeforeBinaryOperators: NonAssignment
Echo BreakBeforeBraces: Custom
Echo BreakInheritanceList: AfterColon
Echo BreakBeforeTernaryOperators: true
Echo BreakConstructorInitializers: BeforeComma
Echo BreakStringLiterals: false
Echo ColumnLimit: 0
Echo ConstructorInitializerAllOnOneLineOrOnePerLine: true
Echo Cpp11BracedListStyle: false
Echo EmptyLineBeforeAccessModifier: LogicalBlock
Echo IndentCaseBlocks: false
Echo IndentCaseLabels: true
Echo IndentPPDirectives: BeforeHash
Echo IndentWidth: 4
Echo NamespaceIndentation: All
Echo PointerAlignment: Left
Echo SortIncludes: false
Echo SpaceBeforeCaseColon: false
Echo TabWidth: 4
Echo UseTab: Always
) > "%outDir%\.clang-format"
