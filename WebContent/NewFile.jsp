<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


	<h2>1. Introduction</h2>
	<p>
		In this tutorial, We&#8217;ll learn <b>how to write programs using
			java 8</b>&nbsp;<br>
		<b><a rel="noopener noreferrer"
			href="https://www.javaprogramto.com/2019/06/java8-lambda-expressions.html"
			target="_blank">lambda and Stream concepts</a></b> with examples. Many
		developers feel learning <b><a rel="noopener noreferrer"
			href="https://www.javaprogramto.com/search/label/Java%208"
			target="_blank">java 8</a></b> concepts may be hard to understand. But
		once we are good using them then feel reduces error prone code and
		improves the performance of the application.
	</p>
	<p>
		Read article on <a rel="noopener noreferrer"
			href="https://java-w3schools.blogspot.com/2018/09/java-8-lambda-expressions-with-examples.html"
			target="_blank">Java 8 Lamda Expression Rules</a>
	</p>
	<p>
		In this article, We will see the example programs on sorting using
		Comparator, File names validation, Retrieving only hidden files and
		filtering list objects based on conditions.<br>
		<a name="more"></a>
	</p>
	<h2>2. Sorting &#8211; Lambda Expression</h2>
	<h3>2.1 Before Java 8</h3>
	<p>See the below code which is implemented in older versions of
		Java. Here trying to sort the Employee&#8217;s based on the id column.</p>
	<div>
		<div id="highlighter_965241" class="syntaxhighlighter  java">
			<table border="0" cellspacing="0" cellpadding="0">
				<tbody>
					<tr>
						<td class="gutter"><div class="line number1 index0 alt2">1</div>
							<div class="line number2 index1 alt1">2</div>
							<div class="line number3 index2 alt2">3</div>
							<div class="line number4 index3 alt1">4</div>
							<div class="line number5 index4 alt2">5</div></td>
						<td class="code"><div class="container">
								<div class="line number1 index0 alt2">
									<code class="java plain">Collections.sort(emplyeesList,
									</code>
									<code class="java keyword">new</code>
									<code class="java plain">Comparator() {</code>
								</div>
								<div class="line number2 index1 alt1">
									<code class="java spaces">&nbsp;</code>
									<code class="java keyword">public</code>
									<code class="java keyword">int</code>
									<code class="java plain">compare(Employee a1, Employee
										a2){</code>
								</div>
								<div class="line number3 index2 alt2">
									<code class="java spaces">&nbsp;&nbsp;</code>
									<code class="java keyword">return</code>
									<code class="java plain">a1.getId().compareTo(a2.getId());</code>
								</div>
								<div class="line number4 index3 alt1">
									<code class="java spaces">&nbsp;</code>
									<code class="java plain">}</code>
								</div>
								<div class="line number5 index4 alt2">
									<code class="java plain">});</code>
								</div>
							</div></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<p>
		Here, written code in 5 lines in which includes <a
			rel="noopener noreferrer"
			href="https://docs.oracle.com/javase/8/docs/api/java/util/Comparator.html"
			target="_blank">Comparator </a>implementation.
	</p>
	<h3>2.2 In Java 8</h3>
	<p>See the below code in Java 8. All the code is in single line and
		not seeing comparing logic.</p>
	<div>
		<div id="highlighter_809424" class="syntaxhighlighter  java">
			<table border="0" cellspacing="0" cellpadding="0">
				<tbody>
					<tr>
						<td class="gutter"><div class="line number1 index0 alt2">1</div></td>
						<td class="code"><div class="container">
								<div class="line number1 index0 alt2">
									<code class="java plain">emplyeesList.sort(Comparator.comparing(Employee::getId));</code>
								</div>
							</div></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<p>Here, Comparator is a Functional Interface which has only one
		abstract method.</p>
	<p>
		Comparator has a static method comparing(.Function.) which accepts
		only Funtion interface.<br>
		<br>https://docs.oracle.com/javase/8/docs/api/java/util/function/Function.html
	</p>
	<blockquote class="wp-block-quote">
		<p>
			<i>Note: Function&lt;T, R&gt; also a Functional Interface. This
				has a method apply(T t) which will be called from
				Comparator.comparing() method.</i>
		</p>
	</blockquote>
	<h2>3. File Name Validation with Lambda Expression</h2>
	<h3>3.1 Before Java 8</h3>
	<p>
		See the code in java old version. Here the core logic is<br>
		<i>file.getName().<a
			href="https://java-w3schools.blogspot.com/2019/03/java-string-endswith.html"
			target="_blank" rel="noopener noreferrer">endsWith</a>(&#8220;.xml&#8221;)
		</i>; The remaining code is just syntax.
	</p>
	<div>
		<div id="highlighter_216259" class="syntaxhighlighter  java">
			<table border="0" cellspacing="0" cellpadding="0">
				<tbody>
					<tr>
						<td class="gutter"><div class="line number1 index0 alt2">1</div>
							<div class="line number2 index1 alt1">2</div>
							<div class="line number3 index2 alt2">3</div>
							<div class="line number4 index3 alt1">4</div>
							<div class="line number5 index4 alt2">5</div></td>
						<td class="code"><div class="container">
								<div class="line number1 index0 alt2">
									<code class="java plain">File[] hiddenFiles = </code>
									<code class="java keyword">new</code>
									<code class="java plain">File(</code>
									<code class="java string">"directory_name"</code>
									<code class="java plain">).listFiles(</code>
									<code class="java keyword">new</code>
									<code class="java plain">FileFilter() {</code>
								</div>
								<div class="line number2 index1 alt1">
									<code class="java spaces">&nbsp;</code>
									<code class="java keyword">public</code>
									<code class="java keyword">boolean</code>
									<code class="java plain">accept(File file) {</code>
								</div>
								<div class="line number3 index2 alt2">
									<code class="java spaces">&nbsp;&nbsp;</code>
									<code class="java keyword">return</code>
									<code class="java plain">file.getName().endsWith(</code>
									<code class="java string">".xml"</code>
									<code class="java plain">);</code>
								</div>
								<div class="line number4 index3 alt1">
									<code class="java spaces">&nbsp;</code>
									<code class="java plain">}</code>
								</div>
								<div class="line number5 index4 alt2">
									<code class="java plain">});</code>
								</div>
							</div></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<h3>3.2 In Java 8</h3>
	<p>The above code is simplified to single line which reduces the
		errors.</p>
	<div>
		<div id="highlighter_269045" class="syntaxhighlighter  java">
			<table border="0" cellspacing="0" cellpadding="0">
				<tbody>
					<tr>
						<td class="gutter"><div class="line number1 index0 alt2">1</div></td>
						<td class="code"><div class="container">
								<div class="line number1 index0 alt2">
									<code class="java plain">File[] hiddenFiles = </code>
									<code class="java keyword">new</code>
									<code class="java plain">File(</code>
									<code class="java string">"directory_name"</code>
									<code class="java plain">).listFiles( file -&gt;
										file.getName().endsWith(</code>
									<code class="java string">".xml"</code>
									<code class="java plain">));</code>
								</div>
							</div></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<blockquote class="wp-block-quote">
		<p>
			<i>Note: Java 8, just focus on the business logic and takes its
				syntax internally. Developer need not to worry about it.</i>
		</p>
	</blockquote>
	<h2>4. Retrieving only Hidden files &#8211; Lambda Expression</h2>
	<h3>4.1 Before java 8</h3>
	<p>File has a method to check the method is hidden or not using
		isHidden() method.</p>
	<div>
		<div id="highlighter_941379" class="syntaxhighlighter  java">
			<table border="0" cellspacing="0" cellpadding="0">
				<tbody>
					<tr>
						<td class="gutter"><div class="line number1 index0 alt2">1</div>
							<div class="line number2 index1 alt1">2</div>
							<div class="line number3 index2 alt2">3</div>
							<div class="line number4 index3 alt1">4</div>
							<div class="line number5 index4 alt2">5</div></td>
						<td class="code"><div class="container">
								<div class="line number1 index0 alt2">
									<code class="java plain">File[] hiddenFiles = </code>
									<code class="java keyword">new</code>
									<code class="java plain">File(</code>
									<code class="java string">"directory_name"</code>
									<code class="java plain">).listFiles(</code>
									<code class="java keyword">new</code>
									<code class="java plain">FileFilter() {</code>
								</div>
								<div class="line number2 index1 alt1">
									<code class="java spaces">&nbsp;</code>
									<code class="java keyword">public</code>
									<code class="java keyword">boolean</code>
									<code class="java plain">accept(File file) {</code>
								</div>
								<div class="line number3 index2 alt2">
									<code class="java spaces">&nbsp;&nbsp;</code>
									<code class="java keyword">return</code>
									<code class="java plain">file.isHidden();</code>
								</div>
								<div class="line number4 index3 alt1">
									<code class="java spaces">&nbsp;</code>
									<code class="java plain">}</code>
								</div>
								<div class="line number5 index4 alt2">
									<code class="java plain">});</code>
								</div>
							</div></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<h3>4.2 In Java 8</h3>
	<p>Just using the new Method Reference concept as part of new Java
		8.</p>
	<div>
		<div id="highlighter_93278" class="syntaxhighlighter  java">
			<table border="0" cellspacing="0" cellpadding="0">
				<tbody>
					<tr>
						<td class="gutter"><div class="line number1 index0 alt2">1</div></td>
						<td class="code"><div class="container">
								<div class="line number1 index0 alt2">
									<code class="java plain">File[] hiddenFiles = </code>
									<code class="java keyword">new</code>
									<code class="java plain">File(</code>
									<code class="java string">"directory_name"</code>
									<code class="java plain">).listFiles(File::isHidden);</code>
								</div>
							</div></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<h2>5. Conclusion</h2>
	<p>In this post, We&#8217;ve seen example lambda program before and
		after Java 8.</p>
	<p>Observed the differences between them. Java 8 were in many ways
		more profound than any other changes to Java in its history.</p>


</body>
</html>