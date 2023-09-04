using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerTankController 
{

    public PlayerTankModel model;
    public PlayerTankView view;
    public Rigidbody rb;

    public void PlayerTankControllerSetting(PlayerTankModel _model, PlayerTankView _view)
    {
       // Debug.Log("Inside the **PlayerTankControllerSetting ");
        model = _model;
        view = _view;
        rb = view.ReturnRb();
        if (rb == null)
        {
           // Debug.Log("Rigidbody is null in PlayerTankController");
        }
        else
        {
           // Debug.Log("Rigidbody is assigned in PlayerTankController");
        }
        model.SetController(this);
        
        model.SetPlayerTankModel(view.dataSo);
       PlayerTankView newView= GameObject.Instantiate(view.gameObject).GetComponent<PlayerTankView>();
        newView.SetController(this);
        newView.gameObject.name = model.name;
    }



    public  void Move(float moveDir)
    {
        //Debug.Log($"model.movementSpeed{movementSpeed}");
        // rb.velocity = view.transform.forward * moveDir * model.movementSpeed;
        rb.velocity = view.transform.forward * moveDir *500;
       
        //Debug.Log($"view.transform.forward * moveDir *40" + view.transform.forward * moveDir * 40);
    }
    public void Rotation(float rotationSpeed, float rotateDir)
    {

        //Quaternion rotationAngle = Quaternion.Euler(new Vector3(0f, rotateDir, 0f));

        //view.transform.rotation = rotationAngle;

    }
}
