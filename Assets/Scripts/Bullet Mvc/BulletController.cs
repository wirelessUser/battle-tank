using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BulletController
{
    private BulletView view;
    private BulletModel model;

    private Rigidbody bulletRb;

    public BulletController(BulletView _view,BulletModel _model)
    {
        view = _view;
        model = _model;
        bulletRb = view.gameObject.GetComponent<Rigidbody>();
        if (bulletRb == null)
        {
            Debug.Log($"bullet rb is NULL");
        }
        view.SetBulletController(this);
        model.SetBulletController(this);

        


    }

    public BulletView SpawnBullet()
    {
       return GameObject.Instantiate(view);

    }


}
