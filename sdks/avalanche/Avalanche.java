/* For when compiling with JNI=1 */
public class Avalanche {
   static {
      System.loadLibrary("game");
   }
   
   private native void launch();
 
   public static void main(String[] args) {
      new Avalanche().launch();
   }
}