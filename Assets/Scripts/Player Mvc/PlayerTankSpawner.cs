using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerTankSpawner : EventManager<PlayerTankSpawner>
{
    private PlayerHealth playerHealth;

    
   // public static PlayerTankSpawner Instance { get; private set; }

    public PlayerTankView tankView;

    public PlayerScriptableObject playerDataSo;

    private PlayerTankView playerSpawned;
    private void Awake()
    {

        MakeInstance();

        SpawnTank();
    }

    private void MakeInstance()
    {
        if (Instance == null)
        {
            Instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
        }

        // Find and store the PlayerHealth component during initialization.
        playerHealth = FindObjectOfType<PlayerHealth>();
    }


    public PlayerHealth ReturnPlayerHealth()
    {
        return playerHealth;
    }
    public void SpawnTank()
    {
        PlayerTankModel tankModel = new PlayerTankModel();
     
        PlayerTankController tankController = new PlayerTankController();

        PlayerTankView playerSpawned = Instantiate(tankView, transform.parent);
       

    }



    public PlayerTankView ReturnView()
    {

        return playerSpawned;
    }
}
