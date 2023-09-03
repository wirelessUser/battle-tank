using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public interface IDestroyObject
{
    public IEnumerator Destroy(float time);
}
