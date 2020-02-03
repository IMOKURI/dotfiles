# Make temp file, delete when script ends
tmpfile=$(mktemp); trap 'rm $tmpfile' 0 1 2 3 15

