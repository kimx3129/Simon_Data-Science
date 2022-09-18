<?php 
$username = "awslearner"; 
$password = "awslearner"; 
$hostname = "yourhostnameaddress"; 
$dbname = "awslearner";
 
//connection to the database
$dbhandle = mysql_connect($hostname, $username, $password) or die("MySQL에 연결할 수 없습니다"); 
echo "MySQL 접속 성공! username - $username, password - $password, host - $hostname<br>"; 
$selected = mysql_select_db("$dbname",$dbhandle) or die("MySQL DB 연결 실패... - 다시 시도해보세요!"); 
?>

