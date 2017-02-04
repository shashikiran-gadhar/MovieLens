<%@ page import = "Gautam.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<html>
	<head>
		<title>
			Recommendations
		</title>
	</head>
	<body bgcolor = "brown">
		<%!
			class values{
				float value;
				int place;
	
				values( float a, int b ){
					value = a;
					place = b;
				}
			}
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;
			File file = new File( "E:/Javaprogs/JDBC/similarity.txt" );
			FileReader fr;
			BufferedReader br;
			String x = null;
			String query1;
			String query2 = " SELECT moviename FROM movie_info WHERE movieid = ";
			values vals[] = new values[200];
			int movid = 0;
			int c = 0;
			String y[] = null;
		%>
		<%
			try{
			query1 = " SELECT movieid FROM movie_info WHERE moviename like '%"+ request.getParameter( "movie" ) +"%'";
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
			
			while( c++ < movid) x = br.readLine();
			
			y = x.split( " " );
			for( int i = 0 ; i < 200 ; i++ )
				vals[i] = new values( Float.parseFloat( y[i] ), i );
				
			for( int pass = 0 ; pass < 200 ; pass++ )
				for( int j = 0 ; j < 199 - pass ; j++ )
					if( vals[j].value < vals[j+1].value ){
						values temp = vals[j];
						vals[j] = vals[j+1];
						vals[j+1] = temp;
					}
			y = new String[20];
			for( int i = 0, j = 0 ; j < 20 ; i++, j++ ){
				if( vals[i].place != movid - 1 ){
					rs = stmt.executeQuery( query2 + ( vals[i].place + 1 ) );
					rs.next();
					y[j] = rs.getString( 1 );
				}
				else{
					j--;
				}
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
			<center>
			<h1>Recommendations</h1>
			<hr><br><br><br><br>
			</center>
			<form action = "http://localhost:8080/examples/jsp/jsp2/el/Moveelens.jsp" method = "post">
				<input type = "radio" name = "movies1" value = "<%=y[0]%>" /><%=y[0]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[1]%>" /><%=y[1]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[2]%>" /><%=y[2]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[3]%>" /><%=y[3]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[4]%>" /><%=y[4]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[5]%>" /><%=y[5]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[6]%>" /><%=y[6]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[7]%>" /><%=y[7]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[8]%>" /><%=y[8]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[9]%>" /><%=y[9]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[10]%>" /><%=y[10]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[11]%>" /><%=y[11]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[12]%>" /><%=y[12]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[13]%>" /><%=y[13]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[14]%>" /><%=y[14]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[15]%>" /><%=y[15]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[16]%>" /><%=y[16]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[17]%>" /><%=y[17]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[18]%>" /><%=y[18]%><br>
				<input type = "radio" name = "movies1" value = "<%=y[19]%>" /><%=y[19]%><br>
				<input type = "submit" hspace = "100" value = "SUBMIT" >
			</form>
	</body>
</html>