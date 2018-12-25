using UnityEngine;
using UnityEditor;
using System;

public class FBXScaleOverride : AssetPostprocessor
{
    void OnPreprocessModel()
    {
        ModelImporter importer = assetImporter as ModelImporter;
        String name = importer.assetPath.ToLower();
        if (name.Substring(name.Length - 4, 4) == ".fbx")
        {
            importer.globalScale = 1.0F;
            importer.generateAnimations = ModelImporterGenerateAnimations.None;
        }
    }

    void OnTexOnPreprocessTexture()
    {
        TextureImporter tex = assetImporter as TextureImporter;
        String name = tex.assetPath.ToLower();
        if (name.Substring(name.Length - 4, 4) == ".png")
        {
            tex.filterMode = FilterMode.Point;
            tex.mipmapEnabled = false;
        }
    }
}