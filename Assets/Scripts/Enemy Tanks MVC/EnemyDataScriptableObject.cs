using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName ="EnemyTank",menuName ="EnemyTank/TankType")]
public class EnemyDataScriptableObject : ScriptableObject
{

    public string EnemyName;
    public EnemyTankType tankType;
    public int health;
    public float damage;
    public float movementSpeed;
    public float rotationSpeed;
}
