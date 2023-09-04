using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using UnityEngine.AI;
public class EnemyBehaviourChaseAndPatrol : MonoBehaviour, IGetComponentsInAwake, IinitializeVariables
{
    public Transform playerTarget;
    public EnemyStates enemyStates;
    private NavMeshAgent navMeshAgent;

    public float patrolSpeed;
    public float chaseSpeed;

    public float chasingDistance;
    public float attackDistance;

    public float currentChaseDistance;

    public float AttackDistance;
    public float chaseAfterAtackDistance = 2f;

    public float attackTimer;
    public float idleAttackTimeGap = 5;
    public float PatrolMinRadius = 20;
    public float patrolMaxradius = 60;
    public float patrolTimer;
    public float idlePatrolTime = 20f;

    private Transform cubeLocator;
    public EnemyView tankView;

    public EnemyShootingBehaviour enemyShootingBehaviour;

    private BulletSpanwer bulletSpawner;
    private void Awake()
    {
        GetComponenetsInAwake();
        InitializeVariables();
    }


    public void InitializeVariables()
    {
        patrolTimer = idlePatrolTime;
        currentChaseDistance = chasingDistance;
        attackTimer = idleAttackTimeGap;
    }
    public void GetComponenetsInAwake()
    {
        bulletSpawner = GameObject.FindWithTag("BulletSpawner").GetComponent<BulletSpanwer>();
        navMeshAgent = GetComponent<NavMeshAgent>();
        cubeLocator = GameObject.Find("Cube").GetComponent<Transform>();

        tankView = GetComponent<EnemyView>();
    }

    private void Start()
    {
        enemyStates = EnemyStates.Patrol;
        playerTarget = GameObject.FindAnyObjectByType<PlayerTankView>().GetComponent<Transform>();

    }

    private void Update()
    {
        UpdateEnemyBehaviourOnStatesChnage();

    }

    public void UpdateEnemyBehaviourOnStatesChnage()
    {
        if (enemyStates == EnemyStates.Patrol)
        {
            Patrol();
        }
        else if (enemyStates == EnemyStates.Chase)
        {
            Chase();

        }
        else if (enemyStates == EnemyStates.Attack)
        {
            Attack();
        }
    }

    private void Patrol()
    {
        ChekDistanceToChaseOrAttack(chasingDistance, EnemyStates.Chase);
        navMeshAgent.isStopped = false;
        navMeshAgent.speed = patrolSpeed;

        patrolTimer += Time.deltaTime;

        if (patrolTimer > idlePatrolTime)
        {
            SetNewDestinationPointForEnemy();
            patrolTimer = 0;
        }


        if (navMeshAgent.velocity.sqrMagnitude > 0.5)
        {
            tankView.PlayParticleTrailEffect(true);
        }
        else
        {
            tankView.PlayParticleTrailEffect(false);
        }
        
      //  Debug.Log($"From Patrol** Distace B/W = {Vector3.Distance(transform.position, playerTarget.position)}");
    }

    private void SetNewDestinationPointForEnemy()
    {
       
       
        float randomRadius = Random.Range(PatrolMinRadius, patrolMaxradius);
        //Debug.Log($"randomRadius = {randomRadius}");
        Vector3 dir = Random.insideUnitSphere;
       // Debug.Log($"dir = {dir}");
        dir *= (randomRadius);
       // Debug.Log($"dir2 = {dir}");
       // dir += transform.position;
        //Debug.Log($"dir3 = {dir}");
        NavMeshHit hit;
        
        NavMesh.SamplePosition(dir, out hit, randomRadius, -1);
        Debug.Log($"hit = {hit.position}");
       // Debug.Log($"hit/2 = {hit.position/2}");
        cubeLocator.transform.position = hit.position;
        navMeshAgent.SetDestination(hit.position);
        

    }

    private void Chase()
    {
        navMeshAgent.isStopped = false;
        navMeshAgent.speed = chaseSpeed;
        navMeshAgent.SetDestination(playerTarget.position);
        //ChekDistanceToChaseOrAttack(attackDistance,EnemyStates.Attack);
        if (Vector3.Distance(transform.position, playerTarget.position) <= attackDistance)
        {
            enemyStates = EnemyStates.Attack;
            if (chasingDistance != currentChaseDistance)
            {
                chasingDistance = currentChaseDistance;
            }
        }
        else if (Vector3.Distance(transform.position, playerTarget.position) > chasingDistance)
        {
            enemyStates = EnemyStates.Patrol;
            navMeshAgent.speed = patrolSpeed;
           // reset patrol timer If it containsa Some differnt valu before going to The chase state..patrolTimer = idlePatrolTime;
            if (chasingDistance != currentChaseDistance)
            {
                chasingDistance = currentChaseDistance;
            }
        }
      //  Debug.Log($"From Chase** Distace B/W = {Vector3.Distance(transform.position, playerTarget.position)}");
    }


    public void ChekDistanceToChaseOrAttack(float distance,EnemyStates _enemyState)
    {
        if (Vector3.Distance(transform.position, playerTarget.position) <= distance)
        {
            enemyStates = _enemyState;
        }
    }
    private void Attack()
    {
        navMeshAgent.isStopped = true;
        navMeshAgent.velocity = Vector3.zero;
        attackTimer += Time.deltaTime;
        if (attackTimer >= idleAttackTimeGap)
        {
            ShootAttack();
            attackTimer = 0;
            
        }
       // Debug.Log($"From Attack** Distace B/W = {Vector3.Distance(transform.position, playerTarget.position)}");
        if (Vector3.Distance(transform.position, playerTarget.position) >= AttackDistance + 10) 
        {
           // Debug.Log($"From Attack** Distace B/W = {Vector3.Distance(transform.position, playerTarget.position)}");
            enemyStates = EnemyStates.Chase;
        }

    }

    private void ShootAttack()
    {
        transform.LookAt(playerTarget);

      //  Debug.Log($"********Shotting************");
        enemyShootingBehaviour.ShootBullet();
    }
}//class...
