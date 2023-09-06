# Extract phase
echo "Extracting data"
# Extract the columns 1 (timestamp), 2 (latitude), 3 (longitude) and 
# 4 (visitorid)
cut -d# -f1-4 web-server-access-log.txt > extracted-data.txt
# Transform phase
echo "Transforming data"
# read the extracted data and replace the colons with commas.
# tr "#" "," < extracted-data.txt 
# extracted-data.txt > transformed.txt
sed 's/#/,/g' extracted-data.txt > transformed.csv
# Load phase 
echo "Loading data" 
# Send the instructions to connect to 'template1' and 
# copy the file to the table 'access_log' through the command pipeline. 
echo "\c template1;\\COPY access_log FROM 'transformed.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost

