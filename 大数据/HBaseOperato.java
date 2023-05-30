package org.example;


import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import org.apache.avro.data.Json;
import org.apache.hbase.thirdparty.com.google.gson.JsonElement;
import org.apache.hbase.thirdparty.com.google.gson.JsonObject;
import org.bson.BSON;
import org.bson.Document;
import org.eclipse.jetty.util.ajax.JSON;

import java.util.HashMap;
import java.util.Map;

public class MongoDBOperator {
    private static MongoClient mongoClient;

    /**
     * 建立MongoDB连接
     */
    public static void init() {
        mongoClient = new MongoClient("localhost", 27017);
        System.out.println("initialize success");
    }

    /**
     * 先将数据解析成Json格式，再通过Json格式的数据创建文档来插入数据
     * 
     * @param DBName 数据库名
     * @param tableName 表名
     * @param keys 列名数组 eg : ["name", "score:math,english,", ...]
     * @param value eg: ["lxy", "91,81,90", ... ]
     */
    public static void createTable(String DBName, String tableName, String[] keys, String[] value) {

        init();

        MongoDatabase database = mongoClient.getDatabase(DBName);
        database.createCollection(tableName);

        MongoCollection<Document> collection = database.getCollection(tableName);
        Document document = Document.parse(jsonifyString(keys, value));

        collection.insertOne(document);

        System.out.println("插入数据成功");

        close();
    }

    /**
     * 打印输出集合中所有数据
     */
    public static void printData(String DBName, String collectionName) {
        init();

        MongoDatabase database = mongoClient.getDatabase(DBName);


        MongoCollection<Document> collection = database.getCollection(collectionName);

        for (Document document : collection.find()) {
            System.out.println(document.toJson());
        }

        close();
    }

    /**
     * 辅助函数
     * 将数据转成Json格式的字符串
     * @param keys
     * @param value
     * @return
     */
    private static String jsonifyString(String[] keys, String[] value) {
        JsonObject jsonObject = new JsonObject();

        for (int i = 0; i < keys.length; i ++) {
            if (keys[i].contains(":")) {

                String[] columns = keys[i].split(":")[1].split(",");
                String[] colsValue = value[i].split(",");
                String key = keys[i].split(":")[0];
                JsonObject object = new JsonObject();

                for (int j = 0; j < columns.length; j ++) {
                   object.addProperty(columns[j], colsValue[j]);
                }
                jsonObject.add(key, object);
            } else {
                jsonObject.addProperty(keys[i], value[i]);
            }
        }

        return jsonObject.toString();
    }

    /**
     * 断开连接
     */
    public static void close() {
        if (mongoClient != null) {
            mongoClient.close();
            mongoClient = null;
        }
    }
}