using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemyAttckState : EnemyTankStates, IGetComponentsInAwake, IinitializeVariables
{
    public float attackTimer;
    public float idleAttackTimeGap = 5;
   // public Color _color;
    // public float attackDistance;
    public EnemyShootingBehaviour enemyShootingBehaviour;

    private BulletSpanwer bulletSpawner;


    public override void OnEnemyEnterState()
    {
        GetComponenetsInAwake();
        base.OnEnemyEnterState();
        enemyview.ChangeColor(color);
        
    }

    public override void OnEnemyExitState()
    {
        base.OnEnemyExitState();
      
    }

    public new void   InitializeVariables()
    {
       
        attackTimer = idleAttackTimeGap;
    }
    public override void Update()
    {
        base.Update();
        Attack();
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
        if (Vector3.Distance(transform.position, playerTransform.position) >= attackDistance + 10)
        {
            // Debug.Log($"From Attack** Distace B/W = {Vector3.Distance(transform.position, playerTarget.position)}");
            enemyview.ChangeEnemyState(enemyview.chasingState );
        }

    }

    private void ShootAttack()
    {
        transform.LookAt(playerTransform);

        //  Debug.Log($"********Shotting************");
      //  enemyShootingBehaviour.ShootBullet();
    }

    public new void GetComponenetsInAwake()
    {
       // enemyview = GetComponent<EnemyView>();
       /// playerTarget = FindObjectOfType<PlayerTankView>();
        bulletSpawner = GameObject.FindWithTag("BulletSpawner").GetComponent<BulletSpanwer>();
      //  navMeshAgent = GetComponent<NavMeshAgent>();
       

        //tankView = GetComponent<EnemyView>();
    }


}
