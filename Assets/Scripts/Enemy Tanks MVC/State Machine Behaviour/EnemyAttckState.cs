using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemyAttckState : EnemyTankStates, IGetComponentsInAwake, IinitializeVariables
{
    public float attackTimer;
    public float idleAttackTimeGap = 5;
  
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
        if (Vector3.Distance(transform.position, playerTransform.position) >= attackDistance + 10)
        {
          
            enemyview.ChangeEnemyState(enemyview.chasingState );
        }

    }

    private void ShootAttack()
    {
        transform.LookAt(playerTransform);

      //  enemyShootingBehaviour.ShootBullet();
    }

    public new void GetComponenetsInAwake()
    {
        bulletSpawner = GameObject.FindWithTag("BulletSpawner").GetComponent<BulletSpanwer>();
       

    }


}
