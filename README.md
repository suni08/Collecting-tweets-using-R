# Wordcloud: Data visualization
Collected tweets using TwitterAPI, python(twitteR) , R from twitter and articles using NYTimesAPI from NYTimes, implemented map-reduce algorithm for word count using Hadoop, and displayed the words using HTML, CSS and JavaScript forming a wordcloud with different fontsizes representing their frequencies.
Step wise execution:

a. Query : H1B
Tweets collected using TwitterAPI : 2000
Articles collected using NYTimes API : 50
Python files attached for collecting the data : tweet_collect.py

b. Hadoop used : given VM image, tested basic word count example provided.

c. Loaded the data TwitterData and NewsData using ssh

Steps:
1.Added Network Adapter for allowing remote connection
2.Set static ip as 192.168.56.10 for Hadoop VM machine
3.Copied files using scp command through ssh	

Commands used : 
scp /Users/sunitapattanayak/Documents/DIC/Lab2/NewsData/* hadoop@192.168.56.10:/home/hadoop/NewsData
scp /Users/sunitapattanayak/Documents/DIC/Lab2/TwitterData/* hadoop@192.168.56.10:/home/hadoop/TwitterData

Folder Structure as shared :
/home/hadoop/TwitterData/resu1.txt, resu1_2.txt : each contains  1000 tweets total:2000
/home/Hadoop/NewsData/resu4.txt, resu4_0.txt, resu4_1.txt, resu4_3.txt, resu4_6.txt, resu4_7.txt, resu4_8.txt : total articles : 50  

d. Language Used : python

Mapper.py : Clean data, removes stop words by using nltk 
Reducer.py : Counts the useful words from output of Mapper.py

Steps:
1.Create Mapper.py that reads each page or text files, cleans them and outputs each word with count 1 as output.
2.Create Reducer.py that count the no. of occurrences of each word and outputs each word with it frequency.
3.Put the output of previous step I.e twitter words text file and NY times words text file in hfs by using following commands:

hdfs dfs -put NewsData/* lab2 
hdfs dfs -put TwitterData/* lab2 
4.Run jar file available to run map reduce function by using following command :

hadoop jar /home/hadoop/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.6.4.jar -mapper mapper.py -reducer reducer.py -input lab2 -output lab2_output 
hdfs dfs –cat lab2_output/* >> output.txt

e,f,g. Use output.txt file to visualize using d3.js and see it interactively on the webpage.
Files used : D3.layout.cloud.js,trial.htm,script.js

Intially data collected : 1000+20
Final data collected : 2000+50

h. Created modified mapper reducer files to search top ten words and find their cooccurrence in each paragraph of articles and each tweets.
1.Mapper1.py : Clean data, removes stop words by using nltk , find occurrence of each top ten word pairs and output tab separated words with 1 as their count
2.Reducer.py : count the no. of occurrences of each word pair and outputs tab separated word pair with its frequency.
3.Put the output of previous step I.e twitter words text file and NY times words text file in hfs by using following commands:

hdfs dfs -put NewsData/* lab2_ext 
hdfs dfs -put TwitterData/* lab2_ext 
4.Run jar file available to run map reduce function by using following command :

hadoop jar /home/hadoop/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.6.4.jar -mapper mapper1.py -reducer reducer.py -input lab2_ext -output lab2_ext_output 
hdfs dfs –cat lab2_output/* >> output_ext.txt

Created convert.py : It converts the text file created into csv file(output_ext.txt to output_ext.csv) which can be easily read by the d3.js code for an interactive website designing.

Steps for running other data :

1.Run the following commands:
	./delete.sh
	./hidden.sh
	CSV files created :
	out.txt and out.csv                           : WordCloud of words
  out_ext.txt and out_ext.csv     : WordCloud of pairwise top 10 words

P.S.: Please rename text file containing articles to be run as file.txt or change the name of file in hidden.sh

2.Run the following d3.js files:
	wordcloud_input.html: Input text in text area to save as file along with filename, preferably file.txt which can be downloaded in Downloads folder.
	wordcloud.html: For wordcloud of top 50 occurring words in the articles
	cooccurencewordcloud.html: For wordcloud of pairwise occurring top 10 words in articles

Elaborate steps inside the shell script files :

Please place the text file in another folder, say “TestData”
hdfs dfs -put TestData/* lab2_test 
hadoop jar /home/hadoop/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.6.4.jar -mapper mapper.py -reducer reducer.py -input lab2_test -output lab2_test_output 
hdfs dfs –cat lab2_test_output/* >> output_test.txt
Please change text file name to output_test.txt and csv file name to output_test.csv in convert.py to obtain csv file for interactive wordcloud output
Please change the input file name in script.js to output_test.csv
hadoop jar /home/hadoop/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.6.4.jar -mapper mapper1.py -reducer reducer.py -input lab2 -output lab_test_ext_output
hdfs dfs –cat lab_test_ext_output/* >> output_test_ext.txt
Please change text file name to output_test_ext.txt and csv file name to output_test_ext.csv in convert.py to obtain csv file for interactive wordcloud output
Please change the input file name in script.js to output_test_ext.csv

The hdfs directory structure should contain the following :

lab2_test
lab2_test_output
lab2_test_ext_output

The Hadoop home directory structure should contain the following :

output_test.txt and output test.csv                    : WordCloud of words
output_test_ext.txt and output_text_ext.csv     : WordCloud of pairwise top 10 words

Other commands used in the project:
hdfs dfs –ls : To list all contents in hdfs
hdfs dfs –rm –r foldername: To delete folders from hdfs

Explaining the html and javascript files:

Wordcloud.html: Creates a wordcloud for first 50 highest occurring words
cooccurencewordcloud.html: Creates a wordcloud for pairwise occurrence of top 10 words from first output file 
wordcloud_input.html: Text Area to save as file along with filename, preferably file.txt
script1.js, script2.js : Java Script for creating wordclouds
	
wordcloud java scripts files script.js and d3.layout.cloud.js : Wordcloud layout by Jason Davies, http://www.jasondavies.com/word-cloud/ and modified as per requirements of the project.

	



