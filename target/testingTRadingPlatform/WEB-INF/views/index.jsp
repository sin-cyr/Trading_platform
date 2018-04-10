<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Trading platform</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!--Link to .css files-->
<link rel="stylesheet" href="resources/css/homepage.css">
<link rel="stylesheet" href="resources/css/login.css">
</head>
<body>

<!-- Navigation button -->
<div class="container-fluid">
<nav class="navbar navbar-default navbar-fixed-top">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
      </button>
      <a class="navbar-brand" href="#">Logo</a>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#register" data-toggle="modal" data-target="#myModal">REGISTER </a></li>
        <li><a href="#login" data-toggle="modal" data-target="#myModal2">LOGIN</a></li>
      </ul>
</nav>
</div>


<!-- Register Modal -->
<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4><span class="glyphicon glyphicon-lock"></span> REGISTER</h4>
      </div>
      <div class="modal-body">
        <form name='form-login' action="Login" method="post">
          <div class="form-group">
            <label for="psw"><span class="glyphicon glyphicon-user"></span> Username</label>
            <input type="text" class="form-control" id="username" placeholder="username" required>
          </div>
          <div class="form-group">
            <label for="usrname"><span class="glyphicon glyphicon-user"></span> Password</label>
            <input type="password" class="form-control" id="password" placeholder="password" required>
          </div>
          <div class="form-group">
            <label for="psw"><span class="glyphicon glyphicon-user"></span> Confirm password</label>
            <input type="password" class="form-control" id="password2" placeholder="pasword" required>
          </div>
          <button type="submit" class="btn btn-block">Submit 
            <span class="glyphicon glyphicon-ok"></span>
          </button>
        </form>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal">
          <span class="glyphicon glyphicon-remove"></span> Cancel
        </button>
        <p>Existing user? <a href="#">login</a></p>
      </div>
    </div>
  </div>
</div>

<!-- Login Modal -->
<div class="modal fade" id="myModal2" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4><span class="glyphicon glyphicon-lock"></span> LOGIN</h4>
      </div>
      <div class="modal-body">
        <form name='form-login' action="LoginGet" method="post">
          <div class="form-group">
            <label for="psw"><span class="glyphicon glyphicon-user"></span> Email</label>
            <input type="text" class="form-control" placeholder="e@ma.il" name="email">
          </div>
          <div class="form-group">
            <label for="usrname"><span class="glyphicon glyphicon-user"></span> Password</label>
            <input type="password" class="form-control" id="password" placeholder="password" required>
          </div>
          <button type="submit" class="btn btn-block">Submit 
            <span class="glyphicon glyphicon-ok"></span>
          </button>
        </form>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal">
          <span class="glyphicon glyphicon-remove"></span> Cancel
        </button>
        <p>New user? <a href="#">register</a></p>
      </div>
    </div>
  </div>
</div>


	<div id="myCarousel" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
    <li data-target="#myCarousel" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img src="http://www.binaryoptionstrategy.eu/wp-content/uploads/2017/01/BinaryOptionsTradingSignals.jpg" alt="slide 1">
      <div class="carousel-caption">
        <h3>SLIDE 1</h3>
        <p>This is slide 1</p>
      </div> 
    </div>

    <div class="item">
      <img src="http://www.binaryoptionstrategy.eu/wp-content/uploads/2017/01/BinaryOptionsTradingSignals.jpg" alt="slide 2">
      <div class="carousel-caption">
        <h3>SLIDE 2</h3>
        <p>This is slide 2.</p>
      </div> 
    </div>

    <div class="item">
      <img src="http://www.binaryoptionstrategy.eu/wp-content/uploads/2017/01/BinaryOptionsTradingSignals.jpg" alt="slide 3">
      <div class="carousel-caption">
        <h3>SLIDE 3</h3>
        <p>This is slide 3</p>
      </div> 
    </div>
  </div>

  <!-- Left and right controls -->
  <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>

</body>
</html>