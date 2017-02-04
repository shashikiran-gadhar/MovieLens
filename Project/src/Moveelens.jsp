<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>MoveeLens</title>
  </head>
  <body bgcolor = "brown" >
	<%!
		String x[];
		String y[];
		File file = new File( "E:/Javaprogs/JDBC/moviesdetails.dat" );
		FileReader fr;
		BufferedReader br;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String query1;
		String a;
		int c = 0;
		int movid = 0;
		String abc = null;
	%>
	<%
		try{
			query1 = " SELECT movieid FROM movie_info WHERE moviename like '%"+ request.getParameter( "movies1" ) +"%'";
			abc = request.getParameter("movies1");
			fr = new FileReader( file );
			br = new BufferedReader( fr );
			Class.forName( "com.mysql.jdbc.Driver" );
			conn = DriverManager.getConnection( "jdbc:mysql://localhost/movies", "root", "Gautam" );
			stmt = conn.createStatement();
			rs = stmt.executeQuery( query1 );
			
			if( rs.next() )
				movid = rs.getInt( 1 );
			else
				out.println("Nothing recieved");
		%>
			<center><h1>Details</h1></center><hr><br><br>
		<%
			while( c++ < movid) a = br.readLine();
			
			y = a.split( ";", 10 );
			
			for( int i = 0 ; i < 10 ; i++ ){
					x = y[i].split( ":", 2 );
		%>
			<b><%=x[0]%> : </b><i><%=x[1]%></i><br>
		<%
			}	
			}
			catch( Exception e ){
			}
			finally{
				try{
					conn.close();
					stmt.close();
				}
				catch( Exception ex ){
					out.println("Exception" + ex);
				}
			}
	%>
	<a href = "http://localhost:8080/examples/jsp/jsp2/el/Moveelens.html" >Search for Images and Videos</a>
	</body>
</html>