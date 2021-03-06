package arbol;

import java.util.ArrayList;
import java.io.Serializable;

public class ParamsNode extends Node implements Serializable{
  public ArrayList<Value> ids;
  public String type;

  public ParamsNode(String type, int fila, int columna){
    super(fila,columna);
    this.ids = new ArrayList<Value>();
    this.type = type;
  }

  public void push(String id, int fila, int columna){
    Value v = new Value(id, fila, columna);
    ids.add(0,v);
  }

  public String printNode(int depth){
    String json = "{";

    //System.out.println("This ParamsNode holds: "); 

    for (int i = 0; i <= depth; i++){
      //System.out.print("|  ");
    }

    //System.out.print("|-- ");

    json += "\"IDs\" : {";

    int index = 0;
    for(Value id : ids){
        json += "\"ID" + index + "\" : " + id.printNode(depth + 1) + ",";
        index ++;
    }

    json = json.substring(0, json.length()-1);
    json += "},";
    
    json += "\"Type\": \"" + type + "\"";

    for (int i = 0; i <= depth; i++){
      //System.out.print("|  ");
    }

    //System.out.print("|-- ");

    //System.out.print("Type: " + type );
    
    json += "}";
    return json;
  }
}