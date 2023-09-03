using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerTankSpawner : MonoBehaviour
{
    public PlayerTankView tankView;
    //public PlayerTankModel tankModel;

    private void Awake()
    {

      // tankModel = new PlayerTankModel();

        SpawnTank();
    }
    void Start()
    {
        
    }

   
    public void SpawnTank()
    {
        PlayerTankModel tankModel = new PlayerTankModel();
        ///PlayerTankModel tankModel = new PlayerTankModel();
        PlayerTankController tankController = new PlayerTankController();

        tankController.PlayerTankControllerSetting(tankModel, tankView);
    }
}
