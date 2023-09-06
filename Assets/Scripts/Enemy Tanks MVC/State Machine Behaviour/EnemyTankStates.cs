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

    //public float patrolSpeed;
    //public float chaseSpeed;

    //public float chasingDistance;

    //public float currentChaseDistance;
    public float attackDistance;


  //  public float AttackDistance;
    public float chaseAfterAtackDistance = 2f;

    //public float attackTimer;
    //public float idleAttackTimeGap = 5;
    //public float PatrolMinRadius = 20;
    //public float patrolMaxradius = 60;
    //public float patrolTimer;
    //public float idlePatrolTime = 20f;

   
    public EnemyView tankView;

    //public EnemyShootingBehaviour enemyShootingBehaviour;

    //private BulletSpanwer bulletSpawner;
    private void Awake()
    {
       

        GetComponenetsInAwake();
        InitializeVariables();
    }

    private void Start()
    {
            
    }
    //protected void SetNewDestinationPointForEnemy()
    //{


    //    float randomRadius = Random.Range(PatrolMinRadius, patrolMaxradius);
    //    //Debug.Log($"randomRadius = {randomRadius}");
    //    Vector3 dir = Random.insideUnitSphere;
    //    // Debug.Log($"dir = {dir}");
    //    dir *= (randomRadius);
    //    // Debug.Log($"dir2 = {dir}");
    //    // dir += transform.position;
    //    //Debug.Log($"dir3 = {dir}");
    //    NavMeshHit hit;

    //    NavMesh.SamplePosition(dir, out hit, randomRadius, -1);
    //    Debug.Log($"hit = {hit.position}");
    //    // Debug.Log($"hit/2 = {hit.position/2}");
    //    cubeLocator.transform.position = hit.position;
    //    navMeshAgent.SetDestination(hit.position);


    //}
  
    public virtual void OnEnemyEnterState() {
        this.enabled = true;
    }
    public virtual void OnEnemyExitState() {
        this.enabled = false;
    }
    //public virtual void Update() { }
    public virtual void Update() { }


    public void InitializeVariables()
    {
        //patrolTimer = idlePatrolTime;
        //currentChaseDistance = chasingDistance;
        //attackTimer = idleAttackTimeGap;
    }
    public void GetComponenetsInAwake()
    {
        enemyview = GetComponent<EnemyView>();
        playerTarget = FindObjectOfType<PlayerTankView>();
        playerTransform = FindObjectOfType<PlayerTankView>().GetComponent<Transform>();
        //bulletSpawner = GameObject.FindWithTag("BulletSpawner").GetComponent<BulletSpanwer>();
        navMeshAgent = GetComponent<NavMeshAgent>();
        //cubeLocator = GameObject.Find("Cube").GetComponent<Transform>();

        tankView = GetComponent<EnemyView>();
    }


}
