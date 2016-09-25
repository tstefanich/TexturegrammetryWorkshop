import java.util.Date;

// Global Variable for master tilesheet
PImage tilesheet;

// Clobgal Variable for master image array
// **969 is the total number of images in this theme
PImage[] tiles = new PImage[969];

// Variable for countingNumber of Images
int imageCounter = 0;

// Dimensions of Image Tiles
int DIM_X = 128;
int DIM_Y = 128;

//This value will "zoom" into the image
float resizeAmount = 1;  


void setup() {
  
  // Set Processing Window Size
  size(128,128);
  
  // Load Screenshot to break into pieces.
  // Just replace screenshot.png with your 
  // image of choice
  tilesheet = loadImage(sketchPath() +"/image-source/screenshot.png");
  
  // Resize Tilesheet to "zoom" in or "zoom" out 
  tilesheet.resize(floor(tilesheet.width * resizeAmount), floor(tilesheet.height * resizeAmount));
  
  // Path + folder name of theme
  String path = sketchPath() + "/your-minecraft-texture-from-1.9" ;

  String[] filenames = listFileNames(path);
  //println("Listing all filenames in a directory: ");
  //println(filenames);
  
  //println("\nListing info about all files in a directory and all subdirectories: ");  
  ArrayList<File> allFiles = listFilesRecursive(path);
  
  for (File f: allFiles) {
    int x = floor(random(0, tilesheet.width - DIM_X));
    int y = floor(random(0, tilesheet.height - DIM_Y)); 
    
    // This function can be used to debug and 
    // print file information
    //printFileInfo(f);
    
    if(isItAnImage(f.getName()) == true){
      tiles[imageCounter] = tilesheet.get(x, y, DIM_X, DIM_Y);
      image(tiles[imageCounter], 0,0);
      save(f.getAbsolutePath());
      imageCounter++;
    }
  }
}

// Draw is only here to draw your tiles to the screen once 
// the program is finished
void draw() 
{
  image(tiles[frameCount%tiles.length], 0,0);
  frameRate(3);
}

// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list of all files in a directory and all subdirectories
ArrayList<File> listFilesRecursive(String dir) {
   ArrayList<File> fileList = new ArrayList<File>(); 
   recurseDir(fileList,dir);
   return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList<File> a, String dir) {
  File file = new File(dir);
 
  if (file.isDirectory() && file.getName() != "colormap") {
    
    //This conditional is for ignoring the colormap folder
    if(file.getName().equals("colormap") == true){
      println("ignore");
    } else {
      // If you want to include directories in the list
      a.add(file);
      File[] subfiles = file.listFiles();
      for (int i = 0; i < subfiles.length; i++) {
        // Call this function on all files in this directory
        recurseDir(a,subfiles[i].getAbsolutePath());
      }
    }
  } else {
    a.add(file);
  }
}

// Simple Function to check if file is an image
boolean isItAnImage(String loadPath) {
  return (
     loadPath.endsWith(".jpg") ||
     loadPath.endsWith(".jpeg") ||
     loadPath.endsWith(".png")  ) ;
}

// Function for Printing information
void printFileInfo(File f){
    println("Name: " + f.getName());
    println("Full path: " + f.getAbsolutePath());
    println("Is directory: " + f.isDirectory());
    println("Size: " + f.length());
    String lastModified = new Date(f.lastModified()).toString();
    println("Last Modified: " + lastModified);
    println("-----------------------");
    println(isItAnImage(f.getName()) == true);
}