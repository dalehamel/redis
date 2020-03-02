/*
 * Copyright (c) <2019> whoever, I don't care
 */
provider redis {
   /**
    * Connection handling.
    */

   /**
    * Fired when a new connection object is created.
    * @param ptr pointer to the connection object
    */
   probe conn__create(const void *ptr);

   /**
    * Fired when a connection is made across a socket.
    * @param ptr pointer to the connection object
    */
   probe conn__accept(const void *ptr);

   /**
    * Fired when the connection across the socket was successfully
    * created.
    * @param conn pointer to the connection object
    * @param addr address being connected to
    * @param port port used for the connection
    * @param srcaddr the source address
    */
   probe conn__connect(const void *conn, const char *addr, int port, const char *srcaddr);

   /**
    * Fired when a connection object is attempted to be closed but is
    * currently in use.
    * @param conn pointer to the connection object
    * @param fd the file descriptor being closed
    */
   probe conn__closing(const void *conn, int fd);

   /**
    * Fired when a connection object is freed
    * @param ptr pointer to the connection object
    */
   probe conn__close(const void *ptr);

   /**
    * Fired when a connection is dispatched from the "main thread" to a
    * worker thread.
    * @param connid the connection id
    * @param threadid the thread id
    */
   probe conn__dispatch(int connid, int64_t threadid);


   /**
    * Command handling.
    */

   /**
    * Fired when the processing of a command starts.
    * @param connid the connection id
    * @param request the incoming request
    * @param size the size of the request
    */
   probe process__command__start(int connid, const void *request);

   /**
    * Fired when the processing of a command is done.
    * @param connid the connection id
    * @param response the response to send back to the client
    * @param size the size of the response
    */
   probe process__command__end(int connid, const void *response);

   /**
    * Fired for a get-command
    * @param connid connection id
    * @param key requested key
    * @param size size of the key's data (or signed int -1 if not found)
    */
   probe command__get(const void *client, const char *key, int size);

   /**
    * Fired for a set-command
    * @param client pointer to the client struct
    * @param key the key being set
    * @param size the size of the value being set
    */
   probe command__set(const void *client, const char *key, int size);

   /**
    * Fired for a delete command
    * @param client pointer to the client struct
    * @param lazy whether the delete is syncronous or not
    */
   probe command__del(const void *client, int lazy);

   /**
    * Fired when clients are paused on the server
    * @param end the unixtime in ms of when the pause should end
    */
   probe clients__paused(int end);

   /**
    * Database interaction
    */

   /**
    * Fired when a key is being deleted from the DB
    * @param db the ordinal of the db the key is being deleted from
    * @param key the key being deleted
    */
   probe db__delete__key(int db, const char *key);

   /**
    * Fired when a database is about to be flushed
    * @param db the ordinal of the db the key is being deleted from. May be -1
    */
   probe db__flush__start(int db)

   /**
    * Fired when a database is about to be flushed
    * @param db the ordinal of the db the key is being deleted from. May be -1
    * @param count the number of keys removed
    */
   probe db__flush__end(int db, int count)

   /**
    * Redis output buffer and replication probes
    */

   /**
    * Fired when redis writes to the client-output-buffer
    * @param connid client id
    * @param size bytes written
    */
   probe client__output__buffer__written(int connid, int size);

   /**
    * Fired when a client output buffer overflows and the client is forcibly
    * closed.
    * @param client a pointer to the current client
    */
   probe client__output__buffer__overflow(const void *client);

   /**
    * Fired when a replica has its output buffer flushed
    * @param client a pointer to the replica client
    */
   probe replica__output__buffer__flushed(const void *client);
};

#pragma D attributes Unstable/Unstable/Common provider redis provider
#pragma D attributes Private/Private/Common provider redis module
#pragma D attributes Private/Private/Common provider redis function
#pragma D attributes Unstable/Unstable/Common provider redis name
#pragma D attributes Unstable/Unstable/Common provider redis args
