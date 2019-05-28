#include <windows.h>
#include <string>
#include <shlobj.h>
#include <iostream>
#include <fstream>
#include <sstream>

// cose
static int CALLBACK BrowseCallbackProc(HWND hwnd,UINT uMsg, LPARAM lParam, LPARAM lpData)
{

    if(uMsg == BFFM_INITIALIZED)
    {
        std::string tmp = (const char *) lpData;
        // std::cout << "path: " << tmp << std::endl;
        SendMessage(hwnd, BFFM_SETSELECTION, TRUE, lpData);
    }

    return 0;
}

// dialogBox per scegliere file
std::string BrowseFolder(std::string saved_path)
{
    TCHAR path[MAX_PATH];

    const char * path_param = saved_path.c_str();

    BROWSEINFO bi = { 0 };
    bi.lpszTitle  = ("Scegli un nuovo file o cartella da aggiungere alla lista backup...");
    bi.ulFlags    = BIF_RETURNONLYFSDIRS | BIF_NEWDIALOGSTYLE;
    bi.lpfn       = BrowseCallbackProc;
    bi.lParam     = (LPARAM) path_param;

    LPITEMIDLIST pidl = SHBrowseForFolder ( &bi );

    if ( pidl != 0 )
    {
        //get the name of the folder and put it in path
        SHGetPathFromIDList ( pidl, path );

        //free memory used
        IMalloc * imalloc = 0;
        if ( SUCCEEDED( SHGetMalloc ( &imalloc )) )
        {
            imalloc->Free ( pidl );
            imalloc->Release ( );
        }

        return path;
    }

    return "";
}

// fa scegliere un nuovo file da dialog e lo aggiunge a file backup
int main(int argc, const char *argv[])
{	
	// chiede path di un file/dir da dialog
    std::string path = BrowseFolder("C:\\");
    
    // scrive path su file
     std::ofstream backup_paths;
	 backup_paths.open("file_list.txt", std::ios::out | std::ios::app);
	 backup_paths << path << "\n";
  
  	backup_paths.close();
    return 0;
}
