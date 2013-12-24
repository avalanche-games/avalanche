/* For when compiling with JNI=1 */
package avalanche;
public class Game {
   static {
      System.loadLibrary("game");
   }
   
   public native void launch();
 
   public static void main(String[] args) {
      new Game().launch();
   }
}