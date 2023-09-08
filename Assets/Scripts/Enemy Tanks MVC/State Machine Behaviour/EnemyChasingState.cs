using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemyChasingState : EnemyTankStates, IGetComponentsInAwake, IinitializeVariables
{

    public float chaseSpeed;


    public float chasingDistance;

    public float currentChaseDistance;
    public float patrolSpeed;
    public override void OnEnemyEnterState()
    {
        base.OnEnemyEnterState();
        enemyview.ChangeColor(color);
        Chase();
    }
    public override void OnEnemyExitState()
    {
        base.OnEnemyExitState();
       
    }

    public override void Update()
    {
        base.Update();
        Chase();
        
    }

    private void Chase()
    {
        navMeshAgent.isStopped = false;
        navMeshAgent.speed = chaseSpeed;
        navMeshAgent.SetDestination(playerTransform.position);
        if (Vector3.Distance(transform.position, playerTransform.position) <= attackDistance)
        {
            enemyview.ChangeEnemyState(enemyview.attackState); 
            if (chasingDistance != currentChaseDistance)
            {
                chasingDistance = currentChaseDistance;
            }
        }
        else if (Vector3.Distance(transform.position, playerTransform.position) > chasingDistance)
        {
            enemyview.ChangeEnemyState(enemyview.patrollingState);
            navMeshAgent.speed = patrolSpeed;
            if (chasingDistance != currentChaseDistance)
            {
                chasingDistance = currentChaseDistance;
            }
        }
    }
}
