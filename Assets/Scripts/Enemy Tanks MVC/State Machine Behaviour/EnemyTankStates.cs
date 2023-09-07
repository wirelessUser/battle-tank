using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
public class EnemyTankStates : MonoBehaviour, IGetComponentsInAwake, IinitializeVariables
{

    protected PlayerTankView playerTarget;
    protected EnemyView enemyview;

    [SerializeField]
    protected Color color;

    public Transform playerTransform;
    public EnemyStates enemyStates;
    protected NavMeshAgent navMeshAgent;



    public float attackDistance;


    public float chaseAfterAtackDistance = 2f;



   
    public EnemyView tankView;


    private void Awake()
    {
       

        GetComponenetsInAwake();
        InitializeVariables();
    }

    private void Start()
    {
            
    }
 
    public virtual void OnEnemyEnterState() {
        this.enabled = true;
    }
    public virtual void OnEnemyExitState() {
        this.enabled = false;
    }
    public virtual void Update() { }


   
    public void GetComponenetsInAwake()
    {
        enemyview = GetComponent<EnemyView>();
        playerTarget = FindObjectOfType<PlayerTankView>();
        playerTransform = FindObjectOfType<PlayerTankView>().GetComponent<Transform>();
        navMeshAgent = GetComponent<NavMeshAgent>();

        tankView = GetComponent<EnemyView>();
    }


}
