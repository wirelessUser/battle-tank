using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[CreateAssetMenu(fileName ="BulletScriptable",menuName = "BulletScriptable/BulletType")]
public class BulletScriptable : ScriptableObject
{
    public string BulleteName;
    public float speed;
    public int damageCapacity;
}
