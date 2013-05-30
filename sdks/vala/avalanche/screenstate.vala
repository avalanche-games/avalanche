namespace Avalanche {

public interface ScreenState : GLib.Object {
	public abstract void on_enter ();
	public abstract void on_update ();
	public abstract void on_event (SDL.Event e);
	public abstract void draw ();
	public abstract void on_leave ();
}

}// Avalanche