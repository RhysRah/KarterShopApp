using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class RegisterButton : MonoBehaviour {

	public Text _username, _password, _confirmPassword, _nnid;

	public void Register(){
		string user, pass, nnid;

		user = _username.text;
		pass = _password.text;
		nnid = _nnid.text;

		if (pass != _confirmPassword.text) {
			return;
			//We'll need to tell the user that their passes dont match
		}

		WWWForm form = new WWWForm ();

		form.AddField ("username", user);
		form.AddField ("password", pass);
		form.AddField ("nnid", nnid);

		WWW request = new WWW ("http://winepicgaming.de/mks/register.aspx", form);

		

		while (!request.isDone)
			;
		Debug.Log (request.text);


	}
}
