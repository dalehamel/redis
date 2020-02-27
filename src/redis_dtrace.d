/*
 * Copyright (c) <2019> whoever, I don't care
 */
provider redis {
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
    * @param ptr pointer to the connection object
    */
   probe conn__closing(const void *ptr);

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
    * @param keylen length of the key
    * @param size size of the key's data (or signed int -1 if not found)
    */
   probe command__get(int connid, const char *key, int keylen, int size);

   /**
    * Fired when clients are paused on the server
    * @param end the unixtime in ms of when the pause should end
    */
   probe clients__paused(int end);

   /**
    * Redis output buffer and replication probes
    */

   /**
    * Fired when redis writes to the client-output-buffer
    * closed.
    * @param connid client id
    * @param size bytes written
    */
   probe client__output__buffer__written(int connid, int size);

   /**
    * Fired when a client output buffer overflows and the client is forcibly
    * closed.
    * @param connid client id
    */
   probe client__output__buffer__overflow(int connid);

   /**
    * Fired when a replica has its output buffer flushed
    * @param connid client id
    */
   probe replica__output__buffer__flushed(int connid);
};

#pragma D attributes Unstable/Unstable/Common provider redis provider
#pragma D attributes Private/Private/Common provider redis module
#pragma D attributes Private/Private/Common provider redis function
#pragma D attributes Unstable/Unstable/Common provider redis name
#pragma D attributes Unstable/Unstable/Common provider redis args
