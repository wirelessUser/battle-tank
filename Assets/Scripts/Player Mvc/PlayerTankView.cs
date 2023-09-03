using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerTankView : MonoBehaviour
{
    public PlayerTankController tankController;

    public float horizontalInput;
    public float verticleInput;

    public PlayerScriptableData dataSo;
    public CameraFollow mainCam;
    public Rigidbody rb;

    public BulletSpanwer bulletSpawner;

    public Transform spawnPoint;
   
    private void Awake()
    {
        bulletSpawner = GameObject.Find("BulletSpawner").GetComponent<BulletSpanwer>();
        mainCam = GameObject.Find("Main Camera").GetComponent<CameraFollow>();
        mainCam.CameraSetup(this);
       

    }
    private void Update()
    {
        TakeInput();
        tankController.Move(horizontalInput); // Call Move with horizontalInput


        if (Input.GetKeyDown(KeyCode.Space))
        {
            FireBullet();
        }
    }

    public void SetController(PlayerTankController _tankController)
    {
        tankController = _tankController;
    }
    public void TakeInput()
    {

        horizontalInput = Input.GetAxis("Horizontal1");
        verticleInput = Input.GetAxis("Vertical1");

       rb.velocity = transform.forward * verticleInput * 50;


        Quaternion rotationAngle = Quaternion.Euler(new Vector3(0f, horizontalInput, 0f));
      

        rb.MoveRotation(rb.rotation * rotationAngle);
    }

    public Rigidbody ReturnRb()
    {
        return rb;
        // return GetComponent<Rigidbody>();
    }

  



    public void FireBullet()
    {
        BulletView spawnedBullet = Instantiate(bulletSpawner.view);

        spawnedBullet.transform.localPosition = spawnPoint.position;
        spawnedBullet.transform.localRotation = spawnPoint.rotation;
        spawnedBullet.GetComponent<Rigidbody>().AddForce((spawnPoint.forward * 2000),ForceMode.Force);
    }



 
}
