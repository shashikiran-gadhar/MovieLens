import java.sql.*;
import java.io.*;

public class InsertMovies{
	public static void main( String args[] ){
		Connection conn = null;
		CallableStatement stmt = null;
		File file;
		FileReader fr = null;
		BufferedReader br = null;
		String s1 = null;
		String s[];
		int temp = 0;
		String query = "{ CALL insertmovies(?,?,?) }";
		try{
			file = new File("ratings.dat");
			fr = new FileReader( file );
			br = new BufferedReader( fr );
			
			Class.forName( "com.mysql.jdbc.Driver" );
			System.out.println("loaded");
			conn = DriverManager.getConnection( "jdbc:mysql://localhost/movies", "root", "Gautam" );
			System.out.println("loggedin");
			stmt = conn.prepareCall( query );
			while( temp <= 100000 ){
				s1 = br.readLine();
				s = s1.split( "::", 3 );
				stmt.setInt( 1, Integer.parseInt( s[0] ) );
				stmt.setInt( 2, s[1] );
				stmt.setInt( 3, s[2] );
				stmt.execute();
				System.out.print( " " + ++temp );
			}
			
		}catch( Exception e ){
			System.out.println( "exception" + e );
		}
		finally{
			try{
				conn.close();
				fr.close();
				br.close();
				stmt.close();
				System.out.println("closed");
			}
			catch( Exception ex ){
				System.out.println("Exception" + ex);
			}
		}
	}
}