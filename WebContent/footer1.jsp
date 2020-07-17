<!-- ***** Footer Start ***** -->
<footer>
	<div class="col-lg-12 col-xs-12">
		<div class="left-text-content">
			<p style="text-align: center;">
				Copyright &copy; ExamHub.com 2020 || Designed By: <a
					rel="nofollow noopener" href="#">Sagar Ghodake</a>
			</p>
		</div>
	</div>

</footer>


<!-- jQuery -->
<script src="assets1/js/jquery-2.1.0.min.js"></script>

<!-- Bootstrap -->
<script src="assets1/js/popper.js"></script>
<script src="assets1/js/bootstrap.min.js"></script>

<!-- Plugins -->
<script src="assets1/js/owl-carousel.js"></script>
<script src="assets1/js/scrollreveal.min.js"></script>
<script src="assets1/js/waypoints.min.js"></script>
<script src="assets1/js/jquery.counterup.min.js"></script>
<script src="assets1/js/imgfix.min.js"></script>
<script src="assets1/js/slick.js"></script>
<script src="assets1/js/lightbox.js"></script>
<script src="assets1/js/isotope.js"></script>

<!-- Global Init -->
<script src="assets1/js/custom.js"></script>

<link href="assets1/bootstrap.min.css" rel="stylesheet">

<link href="assets1/datatables.bootstrap4.min.css" rel="stylesheet">

<!-- Bootstrap core JavaScript-->
<script src="assets1/jquery.min.js"></script>

<!-- Page level plugin JavaScript-->
<script src="assets1/jquery.datatables.min.js"></script>

<script src="assets1/datatables.bootstrap4.min.js"></script>
<script>
</script>
<script>
	$(function() {
		var selectedClass = "";
		$("p").click(function() {
			selectedClass = $(this).attr("data-rel");
			$("#portfolio").fadeTo(50, 0.1);
			$("#portfolio div").not("." + selectedClass).fadeOut();
			setTimeout(function() {
				$("." + selectedClass).fadeIn();
				$("#portfolio").fadeTo(50, 1);
			}, 500);

		});
	});
</script>

</body>
</html>