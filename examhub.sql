-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 12, 2020 at 09:36 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `examhub`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `username` varchar(50) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`username`, `password`) VALUES
('sagar', '92668751');

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--

CREATE TABLE `assignment` (
  `assignmentid` int(11) NOT NULL,
  `assignmentdata` varchar(60000) DEFAULT NULL,
  `subjectname` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `blog`
--

CREATE TABLE `blog` (
  `blogid` int(11) NOT NULL,
  `blogtitle` varchar(200) DEFAULT NULL,
  `blogdata` varchar(60000) DEFAULT NULL,
  `linkrealted` varchar(100) DEFAULT NULL,
  `lastedited` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `categoryid` int(11) NOT NULL,
  `categoryname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryid`, `categoryname`) VALUES
(11, 'Software Development'),
(12, 'Software Testing');

-- --------------------------------------------------------

--
-- Table structure for table `exam`
--

CREATE TABLE `exam` (
  `examid` int(11) NOT NULL,
  `examname` varchar(100) NOT NULL,
  `categoryid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `exam`
--

INSERT INTO `exam` (`examid`, `examname`, `categoryid`) VALUES
(6, 'Java', 11),
(7, 'Python', 11);

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `questionid` int(11) NOT NULL,
  `question` varchar(50000) DEFAULT NULL,
  `option1` varchar(500) NOT NULL,
  `option2` varchar(100) NOT NULL,
  `option3` varchar(100) NOT NULL,
  `option4` varchar(100) NOT NULL,
  `answer` varchar(100) NOT NULL,
  `sectionid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`questionid`, `question`, `option1`, `option2`, `option3`, `option4`, `answer`, `sectionid`) VALUES
(13, 'What will be the output of the following program?\r\n\r\nimport java.util.*;\r\npublic class TimeUp {\r\n    public static void main(String[] args) {\r\n        StringBuffer exam = new StringBuffer(\"GATE\");\r\n        Formatter time = new Formatter(exam);\r\n        time.close();\r\n        System.out.println(time);\r\n    }\r\n}\r\n', 'EMPTY', 'GATE', 'Compilation Error', 'Runtime Error', 'Runtime Error', 8),
(14, 'Which four options describe the correct default values for array elements of the types indicated?\r\n\r\n1) int -> 0\r\n2) String -> \"null\"\r\n3) Dog -> null\r\n4) char -> \'\\u0000\'\r\n5) float -> 0.0f\r\n6) boolean -> true\r\n', '1, 2, 3, 4', '1, 3, 4, 5', '2, 4, 5, 6', '3, 4, 5, 6', '1, 3, 4, 5', 8),
(15, 'Which one of these lists contains only Java programming language keywords?', 'class, if, void, long, Int, continue', 'goto, instanceof, native, finally, default, throws', 'try, virtual, throw, final, volatile, transient', 'strictfp, constant, super, implements, do', 'goto, instanceof, native, finally, default, throws', 8),
(16, 'Which will legally declare, construct, and initialize an array?', 'int [] myList = {\"1\", \"2\", \"3\"};', 'int [] myList = (5, 8, 2);', 'int myList [] [] = {4,9,7,0};', 'int myList [] = {4, 3, 7};', 'int myList [] = {4, 3, 7};', 8),
(17, 'Which is a reserved word in the Java programming language?', 'method', 'native', 'subclasses', 'reference', 'native', 8),
(18, 'Which is a valid keyword in java?', 'interface', 'string', 'Float', 'unsigned', 'interface', 8),
(19, 'Which three are legal array declarations?\r\n\r\n1) int [] myScores [];\r\n2) char [] myChars;\r\n3) int [6] myScores;\r\n4) Dog myDogs [];\r\n5) Dog myDogs [7];', '1, 2, 4', '2, 4, 5', '2, 3, 4', 'All are correct.', '1, 2, 4', 8),
(20, 'public interface Foo \r\n{ \r\n    int k = 4; /* Line 3 */\r\n}\r\nWhich three piece of codes are equivalent to line 3?\r\n\r\n1) final int k = 4;\r\n2) public int k = 4;\r\n3) static int k = 4;\r\n4) abstract int k = 4;\r\n5) volatile int k = 4;\r\n6) protected int k = 4;', '1, 2 and 3', '2, 3 and 4', '3, 4 and 5', '4, 5 and 6', '1, 2 and 3', 8),
(21, 'Which one of the following will declare an array and initialize it with five numbers?', 'Array a = new Array(5);', 'int [] a = {23,22,21,20,19};', 'int a [] = new int[5];', 'int [5] array;', 'int [] a = {23,22,21,20,19};', 8),
(22, 'Which three are valid declarations of a char?\r\n\r\n1) char c1 = 064770;\r\n2) char c2 = \'face\';\r\n3) char c3 = 0xbeef;\r\n4) char c4 = \\u0022;\r\n5) char c5 = \'\\iface\';\r\n6) char c6 = \'\\uface\';', '1, 2, 4', '1, 3, 6', '3, 5', '5 only', '1, 3, 6', 8),
(23, 'Which is the valid declarations within an interface definition?', 'public double methoda();', 'public final double methoda();', 'static void methoda(double d1);', 'protected void methoda(double d1);', 'public double methoda();', 8),
(24, 'Suppose that you would like to create an instance of a new Map that has an iteration order that is the same as the iteration order of an existing instance of a Map. Which concrete implementation of the Map interface should be used for the new instance?', 'TreeMap', 'HashMap', 'LinkedHashMap', 'The answer depends on the implementation of the existing instance.', 'LinkedHashMap', 8),
(25, 'Which class does not override the equals() and hashCode() methods, inheriting them directly from class Object?', 'java.lang.String', 'java.lang.Double', 'java.lang.StringBuffer', 'java.lang.Character', 'java.lang.StringBuffer', 8),
(26, 'Which collection class allows you to grow or shrink its size and provides indexed access to its elements, but whose methods are not synchronized?', 'java.util.HashSet', 'java.util.LinkedHashSet', 'java.util.List', 'java.util.ArrayList', 'java.util.ArrayList', 8),
(27, 'You need to store elements in a collection that guarantees that no duplicates are stored and all elements can be accessed in natural order. Which interface provides that capability?', 'java.util.Map', 'java.util.Set', 'java.util.List', 'java.util.Collection', 'java.util.Set', 8),
(28, 'Which interface does java.util.Hashtable implement?', 'Java.util.Map', 'Java.util.List', 'Java.util.HashTable', 'Java.util.Collection', 'Java.util.Map', 8),
(29, 'Which of these keywords are used to define an abstract class?', 'abst', 'abstract', 'Abstract', 'abstract class', 'abstract', 8),
(30, 'Which of these is not abstract?', 'Thread', 'AbstractList', 'List', 'none', 'Thread', 8),
(31, 'What will be the output of the following Java code?\n\n    class A \n    {\n        public int i;\n        private int j;\n    }    \n    class B extends A \n    {\n        void display() \n        {\n            super.j = super.i + 1;\n            System.out.println(super.i + \" \" + super.j);\n        }\n    }    \n    class inheritance \n   {\n        public static void main(String args[])\n        {\n            B obj = new B();\n            obj.i=1;\n            obj.j=2;   \n            obj.display();     \n        }\n   }', '2 2', '3 3', 'Runtime Error', 'Compilation Error', 'Compilation Error', 8),
(32, 'Which of this keyword must be used to inherit a class?', 'super', 'this', 'extent', 'extends', 'extends', 8),
(33, ' A class member declared protected becomes a member of subclass of which type?\n', 'public member', 'private member', 'protected member', 'static member', 'private member', 8),
(34, 'What will be the output of the following Java program?\n\n    class A \n    {\n        int i;\n        void display() \n        {\n            System.out.println(i);\n        }\n    }    \n    class B extends A \n    {\n        int j;\n        void display() \n        {\n            System.out.println(j);\n        }\n    }    \n    class inheritance_demo \n    {\n        public static void main(String args[])\n        {\n            B obj = new B();\n            obj.i=1;\n            obj.j=2;   \n            obj.display();     \n        }\n   }', '0.0', '1.0', '2.0', 'Compilation Error', '2.0', 8),
(35, 'What will be the output of the following Java program?\n\n    class A \n    {\n        public int i;\n        public int j;\n        A() \n        {\n            i = 1;\n            j = 2;\n }\n    }    \n    class B extends A \n    {\n        int a;\n        B() \n        {\n            super();\n        } \n    }    \n    class super_use \n    {\n        public static void main(String args[])\n        {\n            B obj = new B();\n            System.out.println(obj.i + \" \" + obj.j)     \n        }\n   }', '\n1 2             ', '2 1', 'Runtime Error ', 'Compilation Error', '\n1 2             ', 8),
(36, 'Native-protocol pure Java converts ……….. into the ………… used by DBMSs directly.', ' JDBC calls, network protocol', ' ODBC class, network protocol', ' ODBC class, user call', ' JDBC calls, user call', 'JDBC calls, network protocol', 8),
(37, 'break statement is used to\ni) get out of method \nii) end a program\niii) get out of a loop \niv) get out of the system\n', ' 1 & 2', ' 1,2 & 3', ' 1 & 3\n', '3.0', '3.0', 8),
(38, '\nOOP features are\ni) Increasing productivity \nii) Reusability\niii) Decreasing maintenance cost \niv) High vulnerability', ' 1,2 & 4', ' 1,2 & 3', ' 1, 2 & 4', 'none of these', ' 1,2 & 3', 8),
(39, 'Which is the root class of all AWT events', ' java.awt.ActionEvent', ' java.awt.AWTEvent', ' java.awt.event.AWTEvent', ' java.awt.event.Event', 'java.awt.AWTEvent', 8),
(40, 'The command javac is used to\n', ' debug a java program', ' compile a java program', ' interpret a java program', ' execute a java program', ' compile a java program', 8),
(41, 'Which one of the following is true for Java', ' Java is object-oriented and interpreted', ' Java is efficient and faster than C', ' Java is the choice of everyone.', ' Java is not robust.', ' Java is object-oriented and interpreted', 8),
(42, 'Java programs are', ' Faster than others', ' Platform independent', ' Not reusable', ' Not scalable', ' Platform independent', 8);

-- --------------------------------------------------------

--
-- Table structure for table `result`
--

CREATE TABLE `result` (
  `resultid` int(11) NOT NULL,
  `testid` int(11) DEFAULT NULL,
  `studentusername` varchar(100) DEFAULT NULL,
  `maxquestion` int(11) DEFAULT NULL,
  `maxmarks` int(11) DEFAULT NULL,
  `attempted` int(11) DEFAULT NULL,
  `correct` int(11) DEFAULT NULL,
  `obtained` int(11) DEFAULT NULL,
  `view` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `result`
--

INSERT INTO `result` (`resultid`, `testid`, `studentusername`, `maxquestion`, `maxmarks`, `attempted`, `correct`, `obtained`, `view`) VALUES
(4, 9, 'rakshits31', 7, 7, 3, 3, 3, -1),
(5, 9, 'mahesh213', 7, 7, 6, 2, 2, -1),
(6, 9, 'maneesh123', 7, 7, 6, 4, 4, -1),
(7, 9, 'tejasshelar23', 7, 7, 0, 0, 0, -1),
(8, 9, 'anupritishirke', 7, 7, 7, 6, 6, -1),
(9, 9, 'rajashree45', 7, 7, 5, 4, 4, -1),
(10, 9, 'pravin345', 7, 7, 6, 5, 5, -1),
(11, 5, 'akash17', 30, 30, 0, 0, 0, -1),
(12, 9, 'akash17', 7, 7, 2, 1, 1, -1),
(13, 6, 'akash17', 30, 30, 0, 0, 0, -1),
(14, 2, 'akash17', 25, 25, 0, 0, 0, -1);

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

CREATE TABLE `section` (
  `sectionid` int(11) NOT NULL,
  `sectionname` varchar(100) NOT NULL,
  `examid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `section`
--

INSERT INTO `section` (`sectionid`, `sectionname`, `examid`) VALUES
(8, 'Java SE 8', 6),
(9, 'Core Python', 7);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `gender` varchar(100) NOT NULL,
  `dateofbirth` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `contact` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`username`, `password`, `name`, `address`, `gender`, `dateofbirth`, `email`, `contact`) VALUES
('akash17', '92866060', 'Akash Ghodake', 'A/p Shenwadi', 'Male', '2003-05-17', 'akash1705@gmail.com', 6448),
('anupritishirke', '46792755', 'Anupriti Shirke', 'kolhapur.', 'Female', '1995-09-02', 'anupritishirke1995@gmail.com', 7890),
('farhan123', '46792755', 'farhan akthar', 'pune.', 'Male', '1993-12-03', 'farhanak@gmail.com', 45678),
('mahesh213', '46792755', 'mahesh squad', 'kothrud,pune.', 'Male', '1995-01-20', 'mahesh45@gmail.com', 8879),
('maneesh123', '46792755', 'manesh kumar ', 'bihar.', 'Male', '1992-09-11', 'm@gmail.com', 67845),
('pravin345', '46792755', 'pravin singh', 'karvenager,pune', 'Male', '1993-12-16', 'pravin345@gmail.com', 78967),
('rajashree45', '46792755', 'rajashree kumbhar', 'kolhapur.', 'Female', '1994-10-12', 'raju23@gmail.com', 87866),
('rakshits31', '1163280337', 'rakshit sarvotham shetty', 'teleco colony dattanager pune', 'male', '16/11/1992', 'rakshits31@gmail.com', 880),
('ranjeet31', '46792755', 'ranjeet shetty', 'balajinager,pune.', 'Male', '1991-09-19', 'rony54@gmail.com', 8897),
('tejasshelar23', '-1861353340', 'tejas shelar', 'pune', 'Male', '1993-11-16', 'tejasshelar@gmail.com', 77845),
('vallabh123', '2018166324', 'vallabh paratkar', 'kothrud,pune.', 'Male', '1994-11-16', 'vallabhp95@gmail.com', 6789),
('vijay', '0', 'vijay thorat', 'satara', 'Male', '1994-06-16', 'viju@gmail.com', 4957);

-- --------------------------------------------------------

--
-- Table structure for table `studymaterial`
--

CREATE TABLE `studymaterial` (
  `documentid` int(11) NOT NULL,
  `subjectname` varchar(50) DEFAULT NULL,
  `documenttype` varchar(100) DEFAULT NULL,
  `filepath` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `testid` int(11) NOT NULL,
  `testname` varchar(50) NOT NULL,
  `testtype` varchar(30) NOT NULL,
  `maxquestion` int(11) NOT NULL,
  `maxmarks` int(11) NOT NULL,
  `duration` int(11) NOT NULL,
  `testfee` int(5) NOT NULL,
  `examid` int(11) DEFAULT NULL,
  `open` varchar(15) DEFAULT NULL,
  `closes` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`testid`, `testname`, `testtype`, `maxquestion`, `maxmarks`, `duration`, `testfee`, `examid`, `open`, `closes`) VALUES
(2, 'Java SE 8', 'practice', 25, 25, 15, 0, 6, '2020-05-11', '2020-05-25'),
(3, 'Java SE 8 (2)', 'practice', 20, 20, 15, 0, 6, '2020-05-11', '2020-05-18'),
(4, 'Java SE 8 (3)', 'practice', 30, 30, 25, 0, 6, '2020-05-11', '2020-05-20'),
(5, 'Java SE 8', 'mock', 30, 30, 30, 0, 6, '2020-05-11', 'no CLosing Date'),
(6, 'Java SE Eval 2', 'mock', 30, 30, 25, 0, 6, '2020-05-11', 'no CLosing Date'),
(7, 'Java SE Eval 3', 'mock', 30, 30, 25, 0, 6, '2020-05-11', 'no CLosing Date'),
(8, 'Java SE Eval 4', 'mock', 30, 30, 25, 0, 6, '2020-05-11', 'no CLosing Date'),
(9, 'Java SE 8 (4)', 'practice', 7, 7, 5, 0, 6, '2020-05-15', '2020-05-25'),
(10, 'Java SE 8 (5)', 'practice', 12, 12, 7, 0, 6, '2020-06-02', '2020-06-25'),
(11, 'Java SE 8 (6)', 'practice', 15, 15, 10, 0, 6, '2020-06-05', '2020-06-25'),
(12, 'Java SE 8 (7)', 'practice', 15, 15, 10, 0, 6, '2020-06-07', '2020-06-23'),
(13, 'Python Test', 'Practice', 10, 20, 10, 0, 7, '2020-01-30', '2020-01-20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `assignment`
--
ALTER TABLE `assignment`
  ADD PRIMARY KEY (`assignmentid`);

--
-- Indexes for table `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`blogid`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryid`),
  ADD UNIQUE KEY `categoryname` (`categoryname`);

--
-- Indexes for table `exam`
--
ALTER TABLE `exam`
  ADD PRIMARY KEY (`examid`),
  ADD KEY `fk_categoryid` (`categoryid`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`questionid`),
  ADD KEY `fk_sectionid` (`sectionid`);

--
-- Indexes for table `result`
--
ALTER TABLE `result`
  ADD PRIMARY KEY (`resultid`);

--
-- Indexes for table `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`sectionid`),
  ADD KEY `fk_sectionexamid` (`examid`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `studymaterial`
--
ALTER TABLE `studymaterial`
  ADD PRIMARY KEY (`documentid`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`testid`),
  ADD KEY `fk_examid` (`examid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assignment`
--
ALTER TABLE `assignment`
  MODIFY `assignmentid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog`
--
ALTER TABLE `blog`
  MODIFY `blogid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `categoryid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `exam`
--
ALTER TABLE `exam`
  MODIFY `examid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `questionid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `result`
--
ALTER TABLE `result`
  MODIFY `resultid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `section`
--
ALTER TABLE `section`
  MODIFY `sectionid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `studymaterial`
--
ALTER TABLE `studymaterial`
  MODIFY `documentid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `testid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `exam`
--
ALTER TABLE `exam`
  ADD CONSTRAINT `fk_categoryid` FOREIGN KEY (`categoryid`) REFERENCES `category` (`categoryid`);

--
-- Constraints for table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `fk_sectionid` FOREIGN KEY (`sectionid`) REFERENCES `section` (`sectionid`);

--
-- Constraints for table `section`
--
ALTER TABLE `section`
  ADD CONSTRAINT `fk_sectionexamid` FOREIGN KEY (`examid`) REFERENCES `exam` (`examid`);

--
-- Constraints for table `test`
--
ALTER TABLE `test`
  ADD CONSTRAINT `fk_examid` FOREIGN KEY (`examid`) REFERENCES `exam` (`examid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
