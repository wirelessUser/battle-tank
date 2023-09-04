using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerTankView : MonoBehaviour,IGetComponentsInAwake
{
    public PlayerTankController tankController;

    public float horizontalInput;
    public float verticleInput;

    public PlayerScriptableData dataSo;
    public CameraFollow mainCam;
    public Rigidbody rb;

    public BulletSpanwer bulletSpawner;

    public Transform spawnPoint;

    public PlayerShootingBehaviour shootingBehaviour;
    private void Awake()
    {
        GetComponenetsInAwake();
    }

    public void GetComponenetsInAwake()
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

    public void SetController(PlayerTankController _tankController)     // Controller is Seeting those value So tankController of TankView can Be Initilaized.
    {
        tankController = _tankController; 
    }



    public void TakeInput()   // Player Taking Input For Movemtn and Rotation (veticleInput for Rotation and Horizontal for Move)  ........
    {

        horizontalInput = Input.GetAxis("Horizontal1");
        verticleInput = Input.GetAxis("Vertical1");

       rb.velocity = transform.forward * verticleInput * 50;// Player Movement Left Right (Currently I am FAcing Issue Becuase i have wrote this
                                                      // Code in the Contolelr But from there it is not moving and i am not able to figure out why ?...


        Quaternion rotationAngle = Quaternion.Euler(new Vector3(0f, horizontalInput, 0f));
      

        rb.MoveRotation(rb.rotation * rotationAngle);
    }

    public Rigidbody ReturnRb()    
    {
        return rb;        // return the rigidBody To the Player Controller...
        
    }

  



    public void FireBullet()        // FireBullet For the Player tank....
    {
        shootingBehaviour.ShootBullet();
        //BulletView spawnedBullet = Instantiate(bulletSpawner.view);

        //spawnedBullet.transform.localPosition = spawnPoint.position;
        //spawnedBullet.transform.localRotation = spawnPoint.rotation;
        //spawnedBullet.GetComponent<Rigidbody>().AddForce((spawnPoint.forward * 2000),ForceMode.Force);
    }


}
