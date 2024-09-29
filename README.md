# my-scripts

This repo contains a collection of a few scripts that I've written for personal productivity and use.

## organize-includes

This script organizes C or C++ headers alphabetically. Don't worry if your code
is a bit more complex and contains headers later on in the file, the script won't 
touch those. It just checks for lines that start with '#include' and then stops 
checking once it reaches anything else. 

The script will also show you its intended output before writing to the file. 

Invoke with:
`./organize-includes /path/to/file`
