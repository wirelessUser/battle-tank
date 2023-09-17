using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class EventManager<T>:MonoBehaviour where T:MonoBehaviour
{
    public static EventManager<T> Instance;
    internal PlayerScriptableObject playerDataSo;

    public event Action onPlayerDeath;



    private void Awake()
    {

        MakeInstance();

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

      
    }




    public void  PlayerDeathEvent()
    {
        onPlayerDeath?.Invoke();
            
    }
}
