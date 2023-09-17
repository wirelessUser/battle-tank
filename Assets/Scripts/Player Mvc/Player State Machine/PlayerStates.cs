using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerStates : MonoBehaviour
{
    [SerializeField]
    protected Color color;
    protected PlayerScriptableObject playerdatSo;

    private void Awake()
    {
        playerdatSo = PlayerTankSpawner.Instance.playerDataSo;  
    }
    public virtual void OnPlayerEnterState()
    {

        this.enabled = true;
    }

    public virtual void OnPlayerExitState()
    {
        this.enabled = false;
    }

    public virtual void Update()
    {

    }
}
