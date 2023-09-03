using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerTankModel 
{
    public PlayerTankType TankType { get; private set ; }
    public PlayerTankController tankController;
    public string name { get; private set; }
    public int health { get; private set; }

    public float currentHealth;
    public float damage { get; private set; }

    public float movementSpeed { get; private set ; }

    public void SetController(PlayerTankController _tankController)
    {
        tankController = _tankController;
    }
    public void SetPlayerTankModel(PlayerScriptableData data)
    {
       
        name = data.name;
        //Debug.Log($"name{name}");
        health = data.health;
        currentHealth = health;
        damage = data.damage;
        movementSpeed = data.movementSpeed;


    }

}
