component{
	/**
	 * A simple commandbox task to password protect all Excel files in a directory.
	 * Can be used from the command line using the following command:
	 * > box task run
	 * > box task run :password="yourpassword" :directory="~/Downloads/Temp_encypt_test/"
	 */
	function run( required string password, required string directory ){

		loadModules(
			directoryList( path=resolvePath( 'modules/' ), type='dir' )
		);

		var path = fileSystemUtil.resolvePath( directory );
		if (!DirectoryExists(path)) {
			print.redLine("Directory does not exist: #path#");
			return;
		}

		print.blueLine( "Looking in #path#" );
		var files = directoryList( path=path, recurse=true, listInfo="path", filter="*.xlsx", sort="directory", type="file" );
		print.blueLine( "Found #arrayLen(files)# files" );

		
		var spreadsheet  = wirebox.getInstance( "Spreadsheet@spreadsheet-cfml" );
		var successCount = 0;
		var failureCount = 0;
		for ( var filePath in files ) {
			print.line( "File: #filePath#" );

			try {
				print.text( "Processing: ").boldText( filePath.listLast("\/") );
				
				// When encrypted, the zipped files will be stored within an OLE file in the EncryptedPackage stream.
				// If you plan to use POI to actually generate encrypted documents, be aware not to use anything less than agile encryption, because RC4 is not really secure and ECB chaining is problematic too. 
				spreadsheet.getFileHelper().encryptFile(
					filepath  = filePath,
					password  = arguments.password,
					algorithm = "agile"
				);
				
				print.greenLine( "✓" );
				successCount++;
			} catch (any e) {
				print.redLine( "✗ Error: #e.message#" );
				failureCount++;
			}
		}

		// Summary
		print.line();
		print.greenLine( "Successfully protected: #successCount# files" );
		if ( failureCount > 0 ) {
			print.redLine( "Failed to protect: #failureCount# files" );
		}
	}
}
