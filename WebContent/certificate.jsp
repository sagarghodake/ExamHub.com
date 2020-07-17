<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Certificate</title>
</head>
<body>

</body>
<script type="text/javascript">
var contents = "<!doctype html><html><head><style>@media print{ @page {size: landscape; margin: auto;}";
contents += "<style type='text/css'>";
contents += "</style>";
contents += "<body>";
contents += "<div style='float:left;'><img src='https://www.commlabindia.com/_testing/mobiletest/samples/yogesh/tt/certificate_baner.jpg' /></div>";
contents += "<div><br><p class='bodytext'><center><h4>This certificate has been awarded to<h4> </p></div>";
contents += "<div><center><h2 style='color:#330066;'>"+niceName+"</h2></div>";
contents += "<div><p class='bodytext; color:#F10408;'><center><h3> For successfully completing the course </h3></p></div>";
contents += "<div><br><p class='bodytext'><center><h2  style='color:#660033;'>BUILDING A POSITIVE WORKPLACE CULTURE</h2> </p></div>";
contents  += "<div><br><center><h2><p class='normalred'; style='color:#FF0000; margin-bottom:70px;'>Award Date:    '"+dateString+"'</p></h2></div>";
contents += "<div style='float:left;'><br><br><img src='https://www.commlabindia.com/_testing/mobiletest/samples/yogesh/tt/logo.jpg'/></div>";
contents += "<div style='float:left;text-align:center;position:relative;left:20%; '><img src='https://www.commlabindia.com/_testing/mobiletest/samples/yogesh/tt/seal.png' width='150' height='150'/></div>";
contents += "<div style='float:right;'><br><br_____________<br> <br>Training Manager</div>";
contents += "</body>";
contents += "</html>";

myWindow.document.write(contents);

</script>
</html>