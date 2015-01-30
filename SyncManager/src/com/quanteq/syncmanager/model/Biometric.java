/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.quanteq.syncmanager.model;

/**
 *
 * @author voti
 */
public class Biometric {
    private String subtypeid;
    private String typeid;
    private String id;
    private String  data;

    public String getSubtypeid() {
        return subtypeid;
    }

    public void setSubtypeid(String subtypeid) {
        this.subtypeid = subtypeid;
    }

    public String getTypeid() {
        return typeid;
    }

    public void setTypeid(String typeid) {
        this.typeid = typeid;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
    
}
