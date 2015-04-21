//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/network/mtp/actors/ManagerActor.java
//

#line 1 "/Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/network/mtp/actors/ManagerActor.java"

#include "IOSClass.h"
#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/NetworkProvider.h"
#include "im/actor/model/droidkit/actors/Actor.h"
#include "im/actor/model/droidkit/actors/ActorRef.h"
#include "im/actor/model/droidkit/actors/ActorSelection.h"
#include "im/actor/model/droidkit/actors/ActorSystem.h"
#include "im/actor/model/droidkit/actors/Environment.h"
#include "im/actor/model/droidkit/actors/Props.h"
#include "im/actor/model/droidkit/bser/DataInput.h"
#include "im/actor/model/droidkit/bser/DataOutput.h"
#include "im/actor/model/log/Log.h"
#include "im/actor/model/network/ActorApi.h"
#include "im/actor/model/network/Connection.h"
#include "im/actor/model/network/ConnectionEndpoint.h"
#include "im/actor/model/network/Endpoints.h"
#include "im/actor/model/network/mtp/MTProto.h"
#include "im/actor/model/network/mtp/actors/ManagerActor.h"
#include "im/actor/model/network/mtp/actors/ReceiverActor.h"
#include "im/actor/model/network/mtp/actors/SenderActor.h"
#include "im/actor/model/network/mtp/entity/ProtoMessage.h"
#include "im/actor/model/util/AtomicIntegerCompat.h"
#include "im/actor/model/util/ExponentialBackoff.h"
#include "java/io/IOException.h"

__attribute__((unused)) static void MTManagerActor_onConnectionCreatedWithInt_withAMConnection_(MTManagerActor *self, jint id_, id<AMConnection> connection);
__attribute__((unused)) static void MTManagerActor_onConnectionCreateFailure(MTManagerActor *self);
__attribute__((unused)) static void MTManagerActor_onConnectionDieWithInt_(MTManagerActor *self, jint id_);
__attribute__((unused)) static void MTManagerActor_onNetworkChanged(MTManagerActor *self);
__attribute__((unused)) static void MTManagerActor_requestCheckConnection(MTManagerActor *self);
__attribute__((unused)) static void MTManagerActor_requestCheckConnectionWithLong_(MTManagerActor *self, jlong wait);
__attribute__((unused)) static void MTManagerActor_checkConnection(MTManagerActor *self);
__attribute__((unused)) static void MTManagerActor_onInMessageWithByteArray_withInt_withInt_(MTManagerActor *self, IOSByteArray *data, jint offset, jint len);
__attribute__((unused)) static void MTManagerActor_onOutMessageWithByteArray_withInt_withInt_(MTManagerActor *self, IOSByteArray *data, jint offset, jint len);

@interface MTManagerActor () {
 @public
  MTMTProto *mtProto_;
  AMEndpoints *endpoints_;
  jlong authId_;
  jlong sessionId_;
  jint currentConnectionId_;
  id<AMConnection> currentConnection_;
  jboolean isCheckingConnections_;
  AMExponentialBackoff *backoff_;
  DKActorRef *receiver_;
  DKActorRef *sender_;
}

- (void)onConnectionCreatedWithInt:(jint)id_
                  withAMConnection:(id<AMConnection>)connection;

- (void)onConnectionCreateFailure;

- (void)onConnectionDieWithInt:(jint)id_;

- (void)onNetworkChanged;

- (void)requestCheckConnection;

- (void)requestCheckConnectionWithLong:(jlong)wait;

- (void)checkConnection;

- (void)onInMessageWithByteArray:(IOSByteArray *)data
                         withInt:(jint)offset
                         withInt:(jint)len;

- (void)onOutMessageWithByteArray:(IOSByteArray *)data
                          withInt:(jint)offset
                          withInt:(jint)len;
@end

J2OBJC_FIELD_SETTER(MTManagerActor, mtProto_, MTMTProto *)
J2OBJC_FIELD_SETTER(MTManagerActor, endpoints_, AMEndpoints *)
J2OBJC_FIELD_SETTER(MTManagerActor, currentConnection_, id<AMConnection>)
J2OBJC_FIELD_SETTER(MTManagerActor, backoff_, AMExponentialBackoff *)
J2OBJC_FIELD_SETTER(MTManagerActor, receiver_, DKActorRef *)
J2OBJC_FIELD_SETTER(MTManagerActor, sender_, DKActorRef *)

@interface MTManagerActor_OutMessage () {
 @public
  IOSByteArray *message_;
  jint offset_;
  jint len_;
}
@end

J2OBJC_FIELD_SETTER(MTManagerActor_OutMessage, message_, IOSByteArray *)

@interface MTManagerActor_InMessage () {
 @public
  IOSByteArray *data_;
  jint offset_;
  jint len_;
}
@end

J2OBJC_FIELD_SETTER(MTManagerActor_InMessage, data_, IOSByteArray *)

@interface MTManagerActor_PerformConnectionCheck ()
- (instancetype)init;
@end

@interface MTManagerActor_ConnectionDie () {
 @public
  jint connectionId_;
}
@end

@interface MTManagerActor_ConnectionCreateFailure ()
- (instancetype)init;
@end

@interface MTManagerActor_ConnectionCreated () {
 @public
  jint connectionId_;
  id<AMConnection> connection_;
}
@end

J2OBJC_FIELD_SETTER(MTManagerActor_ConnectionCreated, connection_, id<AMConnection>)

@interface MTManagerActor_$1 () {
 @public
  MTMTProto *val$mtProto_;
}
@end

J2OBJC_FIELD_SETTER(MTManagerActor_$1, val$mtProto_, MTMTProto *)

@interface MTManagerActor_$2 () {
 @public
  MTManagerActor *this$0_;
  jint val$id_;
}
@end

J2OBJC_FIELD_SETTER(MTManagerActor_$2, this$0_, MTManagerActor *)

@interface MTManagerActor_$3 () {
 @public
  MTManagerActor *this$0_;
  jint val$id_;
}
@end

J2OBJC_FIELD_SETTER(MTManagerActor_$3, this$0_, MTManagerActor *)

BOOL MTManagerActor_initialized = NO;


#line 28
@implementation MTManagerActor

NSString * MTManagerActor_TAG_ = @"Manager";
AMAtomicIntegerCompat * MTManagerActor_NEXT_CONNECTION_;


#line 32
+ (DKActorRef *)managerWithMTMTProto:(MTMTProto *)mtProto {
  return MTManagerActor_managerWithMTMTProto_(mtProto);
}


#line 60
- (instancetype)initWithMTMTProto:(MTMTProto *)mtProto {
  if (self = [super init]) {
    isCheckingConnections_ =
#line 54
    NO;
    backoff_ =
#line 55
    [[AMExponentialBackoff alloc] init];
    
#line 61
    self->mtProto_ = mtProto;
    
#line 62
    self->endpoints_ = [((MTMTProto *) nil_chk(mtProto)) getEndpoints];
    
#line 63
    self->authId_ = [mtProto getAuthId];
    
#line 64
    self->sessionId_ = [mtProto getSessionId];
  }
  return self;
}


#line 68
- (void)preStart {
  
#line 69
  receiver_ = MTReceiverActor_receiverWithMTMTProto_(mtProto_);
  sender_ = MTSenderActor_senderActorWithMTMTProto_(mtProto_);
  MTManagerActor_checkConnection(self);
}


#line 75
- (void)onReceiveWithId:(id)message {
  
#line 78
  if ([message isKindOfClass:[MTManagerActor_ConnectionCreated class]]) {
    MTManagerActor_ConnectionCreated *c = (MTManagerActor_ConnectionCreated *) check_class_cast(message, [MTManagerActor_ConnectionCreated class]);
    MTManagerActor_onConnectionCreatedWithInt_withAMConnection_(self, ((MTManagerActor_ConnectionCreated *) nil_chk(c))->connectionId_, c->connection_);
  }
  else
#line 81
  if ([message isKindOfClass:[MTManagerActor_ConnectionCreateFailure class]]) {
    MTManagerActor_onConnectionCreateFailure(self);
  }
  else
#line 83
  if ([message isKindOfClass:[MTManagerActor_ConnectionDie class]]) {
    MTManagerActor_onConnectionDieWithInt_(self, ((MTManagerActor_ConnectionDie *) nil_chk(((MTManagerActor_ConnectionDie *) check_class_cast(message, [MTManagerActor_ConnectionDie class]))))->connectionId_);
  }
  else
#line 85
  if ([message isKindOfClass:[MTManagerActor_PerformConnectionCheck class]]) {
    MTManagerActor_checkConnection(self);
  }
  else
#line 87
  if ([message isKindOfClass:[MTManagerActor_NetworkChanged class]]) {
    MTManagerActor_onNetworkChanged(self);
  }
  else
#line 91
  if ([message isKindOfClass:[MTManagerActor_OutMessage class]]) {
    MTManagerActor_OutMessage *m = (MTManagerActor_OutMessage *) check_class_cast(message, [MTManagerActor_OutMessage class]);
    MTManagerActor_onOutMessageWithByteArray_withInt_withInt_(self, ((MTManagerActor_OutMessage *) nil_chk(m))->message_, m->offset_, m->len_);
  }
  else
#line 94
  if ([message isKindOfClass:[MTManagerActor_InMessage class]]) {
    MTManagerActor_InMessage *m = (MTManagerActor_InMessage *) check_class_cast(message, [MTManagerActor_InMessage class]);
    MTManagerActor_onInMessageWithByteArray_withInt_withInt_(self, ((MTManagerActor_InMessage *) nil_chk(m))->data_, m->offset_, m->len_);
  }
}


#line 100
- (void)onConnectionCreatedWithInt:(jint)id_
                  withAMConnection:(id<AMConnection>)connection {
  MTManagerActor_onConnectionCreatedWithInt_withAMConnection_(self, id_, connection);
}


#line 131
- (void)onConnectionCreateFailure {
  MTManagerActor_onConnectionCreateFailure(self);
}


#line 139
- (void)onConnectionDieWithInt:(jint)id_ {
  MTManagerActor_onConnectionDieWithInt_(self, id_);
}


#line 152
- (void)onNetworkChanged {
  MTManagerActor_onNetworkChanged(self);
}


#line 159
- (void)requestCheckConnection {
  MTManagerActor_requestCheckConnection(self);
}

- (void)requestCheckConnectionWithLong:(jlong)wait {
  MTManagerActor_requestCheckConnectionWithLong_(self, wait);
}


#line 176
- (void)checkConnection {
  MTManagerActor_checkConnection(self);
}


#line 223
- (void)onInMessageWithByteArray:(IOSByteArray *)data
                         withInt:(jint)offset
                         withInt:(jint)len {
  MTManagerActor_onInMessageWithByteArray_withInt_withInt_(self, data, offset, len);
}


#line 253
- (void)onOutMessageWithByteArray:(IOSByteArray *)data
                          withInt:(jint)offset
                          withInt:(jint)len {
  MTManagerActor_onOutMessageWithByteArray_withInt_withInt_(self, data, offset, len);
}

- (void)copyAllFieldsTo:(MTManagerActor *)other {
  [super copyAllFieldsTo:other];
  other->mtProto_ = mtProto_;
  other->endpoints_ = endpoints_;
  other->authId_ = authId_;
  other->sessionId_ = sessionId_;
  other->currentConnectionId_ = currentConnectionId_;
  other->currentConnection_ = currentConnection_;
  other->isCheckingConnections_ = isCheckingConnections_;
  other->backoff_ = backoff_;
  other->receiver_ = receiver_;
  other->sender_ = sender_;
}

+ (void)initialize {
  if (self == [MTManagerActor class]) {
    MTManagerActor_NEXT_CONNECTION_ = DKEnvironment_createAtomicIntWithInt_(
#line 42
    1);
    J2OBJC_SET_INITIALIZED(MTManagerActor)
  }
}

@end

DKActorRef *MTManagerActor_managerWithMTMTProto_(MTMTProto *mtProto) {
  MTManagerActor_init();
  
#line 33
  return [((DKActorSystem *) nil_chk(DKActorSystem_system())) actorOfWithDKActorSelection:
#line 34
  [[DKActorSelection alloc] initWithDKProps:DKProps_createWithIOSClass_withDKActorCreator_(MTManagerActor_class_(), [[MTManagerActor_$1 alloc] initWithMTMTProto:mtProto]) withNSString:JreStrcat("$$",
#line 39
  [((MTMTProto *) nil_chk(mtProto)) getActorPath], @"/manager")]];
}

void MTManagerActor_onConnectionCreatedWithInt_withAMConnection_(MTManagerActor *self, jint id_, id<AMConnection> connection) {
  
#line 101
  AMLog_dWithNSString_withNSString_(MTManagerActor_TAG_, JreStrcat("$I$", @"Connection #", id_, @" created"));
  
#line 103
  if ([((id<AMConnection>) nil_chk(connection)) isClosed]) {
    AMLog_wWithNSString_withNSString_(MTManagerActor_TAG_, JreStrcat("$I$", @"Unable to register connection #", id_, @": already closed"));
    return;
  }
  
#line 108
  if (self->currentConnectionId_ == id_) {
    AMLog_wWithNSString_withNSString_(MTManagerActor_TAG_, JreStrcat("$I$", @"Unable to register connection #", id_, @": already have connection"));
    return;
  }
  
#line 113
  if (self->currentConnection_ != nil) {
    [self->currentConnection_ close];
    AMLog_dWithNSString_withNSString_(MTManagerActor_TAG_, @"Set connection #0");
    self->currentConnectionId_ = 0;
  }
  
#line 119
  AMLog_dWithNSString_withNSString_(MTManagerActor_TAG_, JreStrcat("$I", @"Set connection #", id_));
  self->currentConnectionId_ = id_;
  self->currentConnection_ = connection;
  
#line 124
  [((AMExponentialBackoff *) nil_chk(self->backoff_)) onSuccess];
  self->isCheckingConnections_ = NO;
  MTManagerActor_requestCheckConnection(self);
  
#line 128
  [((DKActorRef *) nil_chk(self->sender_)) sendWithId:[[MTSenderActor_ConnectionCreated alloc] init]];
}

void MTManagerActor_onConnectionCreateFailure(MTManagerActor *self) {
  
#line 132
  AMLog_wWithNSString_withNSString_(MTManagerActor_TAG_, @"Connection create failure");
  
#line 134
  [((AMExponentialBackoff *) nil_chk(self->backoff_)) onFailure];
  self->isCheckingConnections_ = NO;
  MTManagerActor_requestCheckConnectionWithLong_(self, [self->backoff_ exponentialWait]);
}

void MTManagerActor_onConnectionDieWithInt_(MTManagerActor *self, jint id_) {
  
#line 140
  AMLog_wWithNSString_withNSString_(MTManagerActor_TAG_, JreStrcat("$I$", @"Connection #", id_, @" dies"));
  
#line 142
  if (self->currentConnectionId_ == id_) {
    AMLog_dWithNSString_withNSString_(MTManagerActor_TAG_, @"Set connection #0");
    self->currentConnectionId_ = 0;
    self->currentConnection_ = nil;
    MTManagerActor_requestCheckConnection(self);
  }
  else {
    
#line 148
    AMLog_wWithNSString_withNSString_(MTManagerActor_TAG_, JreStrcat("$I$I", @"Unable to unregister connection #", id_, @": connection not found, expected: #", self->currentConnectionId_));
  }
}

void MTManagerActor_onNetworkChanged(MTManagerActor *self) {
  
#line 153
  AMLog_wWithNSString_withNSString_(MTManagerActor_TAG_, @"Network configuration changed");
  
#line 155
  [((AMExponentialBackoff *) nil_chk(self->backoff_)) reset];
  MTManagerActor_checkConnection(self);
}

void MTManagerActor_requestCheckConnection(MTManagerActor *self) {
  
#line 160
  MTManagerActor_requestCheckConnectionWithLong_(self, 0);
}

void MTManagerActor_requestCheckConnectionWithLong_(MTManagerActor *self, jlong wait) {
  
#line 164
  if (!self->isCheckingConnections_) {
    if (self->currentConnection_ == nil) {
      if (wait == 0) {
        AMLog_wWithNSString_withNSString_(MTManagerActor_TAG_, @"Requesting connection creating");
      }
      else {
        
#line 169
        AMLog_wWithNSString_withNSString_(MTManagerActor_TAG_, JreStrcat("$J$", @"Requesting connection creating in ", wait, @" ms"));
      }
    }
    [((DKActorRef *) nil_chk([self self__])) sendOnceWithId:[[MTManagerActor_PerformConnectionCheck alloc] init] withLong:wait];
  }
}

void MTManagerActor_checkConnection(MTManagerActor *self) {
  
#line 177
  if (self->isCheckingConnections_) {
    return;
  }
  
#line 181
  if (self->currentConnection_ == nil) {
    AMLog_dWithNSString_withNSString_(MTManagerActor_TAG_, @"Trying to create connection...");
    
#line 184
    self->isCheckingConnections_ = YES;
    
#line 186
    jint id_ = [((AMAtomicIntegerCompat *) nil_chk(MTManagerActor_NEXT_CONNECTION_)) getAndIncrement];
    
#line 188
    [((id<AMNetworkProvider>) nil_chk([((MTMTProto *) nil_chk(self->mtProto_)) getNetworkProvider])) createConnection:id_ withMTProtoVersion:
#line 189
    AMActorApi_MTPROTO_VERSION withApiMajorVersion:
#line 190
    AMActorApi_API_MAJOR_VERSION withApiMinorVersion:
#line 191
    AMActorApi_API_MINOR_VERSION withEndpoint:
#line 192
    [((AMEndpoints *) nil_chk(self->endpoints_)) fetchEndpoint] withCallback:[[MTManagerActor_$2 alloc] initWithMTManagerActor:self withInt:id_] withCreateCallback:
#line 209
    [[MTManagerActor_$3 alloc] initWithMTManagerActor:self withInt:id_]];
  }
}

void MTManagerActor_onInMessageWithByteArray_withInt_withInt_(MTManagerActor *self, IOSByteArray *data, jint offset, jint len) {
  
#line 226
  BSDataInput *bis = [[BSDataInput alloc] initWithByteArray:data withInt:offset withInt:len];
  @try {
    jlong authId = [bis readLong];
    jlong sessionId = [bis readLong];
    
#line 231
    if (authId != self->authId_ || sessionId != self->sessionId_) {
      @throw [[JavaIoIOException alloc] initWithNSString:@"Incorrect header"];
    }
    
#line 235
    jlong messageId = [bis readLong];
    IOSByteArray *payload = [bis readProtoBytes];
    
#line 238
    [((DKActorRef *) nil_chk(self->receiver_)) sendWithId:[[MTProtoMessage alloc] initWithLong:messageId withByteArray:payload]];
  }
  @catch (
#line 239
  JavaIoIOException *e) {
    AMLog_wWithNSString_withNSString_(MTManagerActor_TAG_, @"Closing connection: incorrect package");
    [((JavaIoIOException *) nil_chk(e)) printStackTrace];
    
#line 243
    if (self->currentConnection_ != nil) {
      [self->currentConnection_ close];
      self->currentConnection_ = nil;
      self->currentConnectionId_ = 0;
      AMLog_dWithNSString_withNSString_(MTManagerActor_TAG_, @"Set connection #0");
    }
    MTManagerActor_checkConnection(self);
  }
}

void MTManagerActor_onOutMessageWithByteArray_withInt_withInt_(MTManagerActor *self, IOSByteArray *data, jint offset, jint len) {
  
#line 257
  if (self->currentConnection_ != nil && [self->currentConnection_ isClosed]) {
    self->currentConnection_ = nil;
    AMLog_dWithNSString_withNSString_(MTManagerActor_TAG_, @"Set connection #0");
    self->currentConnectionId_ = 0;
    MTManagerActor_checkConnection(self);
  }
  
#line 264
  if (self->currentConnection_ != nil) {
    BSDataOutput *bos = [[BSDataOutput alloc] init];
    [bos writeLongWithLong:self->authId_];
    [bos writeLongWithLong:self->sessionId_];
    [bos writeBytesWithByteArray:data withInt:offset withInt:len];
    IOSByteArray *pkg = [bos toByteArray];
    [self->currentConnection_ post:pkg withOffset:0 withLen:((IOSByteArray *) nil_chk(pkg))->size_];
  }
  else {
  }
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(MTManagerActor)


#line 277
@implementation MTManagerActor_OutMessage


#line 282
- (instancetype)initWithByteArray:(IOSByteArray *)message
                          withInt:(jint)offset
                          withInt:(jint)len {
  if (self = [super init]) {
    
#line 283
    self->message_ = message;
    
#line 284
    self->offset_ = offset;
    
#line 285
    self->len_ = len;
  }
  return self;
}


#line 288
- (jint)getOffset {
  
#line 289
  return offset_;
}


#line 292
- (jint)getLen {
  
#line 293
  return len_;
}


#line 296
- (IOSByteArray *)getMessage {
  
#line 297
  return message_;
}

- (void)copyAllFieldsTo:(MTManagerActor_OutMessage *)other {
  [super copyAllFieldsTo:other];
  other->message_ = message_;
  other->offset_ = offset_;
  other->len_ = len_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(MTManagerActor_OutMessage)


#line 301
@implementation MTManagerActor_InMessage


#line 306
- (instancetype)initWithByteArray:(IOSByteArray *)data
                          withInt:(jint)offset
                          withInt:(jint)len {
  if (self = [super init]) {
    
#line 307
    self->data_ = data;
    
#line 308
    self->offset_ = offset;
    
#line 309
    self->len_ = len;
  }
  return self;
}


#line 312
- (IOSByteArray *)getData {
  
#line 313
  return data_;
}


#line 316
- (jint)getOffset {
  
#line 317
  return offset_;
}


#line 320
- (jint)getLen {
  
#line 321
  return len_;
}

- (void)copyAllFieldsTo:(MTManagerActor_InMessage *)other {
  [super copyAllFieldsTo:other];
  other->data_ = data_;
  other->offset_ = offset_;
  other->len_ = len_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(MTManagerActor_InMessage)


#line 325
@implementation MTManagerActor_NetworkChanged

- (instancetype)init {
  return [super init];
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(MTManagerActor_NetworkChanged)


#line 329
@implementation MTManagerActor_PerformConnectionCheck

- (instancetype)init {
  return [super init];
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(MTManagerActor_PerformConnectionCheck)


#line 333
@implementation MTManagerActor_ConnectionDie


#line 336
- (instancetype)initWithInt:(jint)connectionId {
  if (self = [super init]) {
    
#line 337
    self->connectionId_ = connectionId;
  }
  return self;
}


#line 340
- (jint)getConnectionId {
  
#line 341
  return connectionId_;
}

- (void)copyAllFieldsTo:(MTManagerActor_ConnectionDie *)other {
  [super copyAllFieldsTo:other];
  other->connectionId_ = connectionId_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(MTManagerActor_ConnectionDie)


#line 345
@implementation MTManagerActor_ConnectionCreateFailure

- (instancetype)init {
  return [super init];
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(MTManagerActor_ConnectionCreateFailure)


#line 349
@implementation MTManagerActor_ConnectionCreated


#line 353
- (instancetype)initWithInt:(jint)connectionId
           withAMConnection:(id<AMConnection>)connection {
  if (self = [super init]) {
    
#line 354
    self->connectionId_ = connectionId;
    
#line 355
    self->connection_ = connection;
  }
  return self;
}


#line 358
- (jint)getConnectionId {
  
#line 359
  return connectionId_;
}


#line 362
- (id<AMConnection>)getConnection {
  
#line 363
  return connection_;
}

- (void)copyAllFieldsTo:(MTManagerActor_ConnectionCreated *)other {
  [super copyAllFieldsTo:other];
  other->connectionId_ = connectionId_;
  other->connection_ = connection_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(MTManagerActor_ConnectionCreated)

@implementation MTManagerActor_$1


#line 36
- (MTManagerActor *)create {
  
#line 37
  return [[MTManagerActor alloc] initWithMTMTProto:val$mtProto_];
}

- (instancetype)initWithMTMTProto:(MTMTProto *)capture$0 {
  val$mtProto_ = capture$0;
  return [super init];
}

- (void)copyAllFieldsTo:(MTManagerActor_$1 *)other {
  [super copyAllFieldsTo:other];
  other->val$mtProto_ = val$mtProto_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(MTManagerActor_$1)

@implementation MTManagerActor_$2

- (void)onConnectionRedirect:(NSString *)host withPort:(jint)port withTimeout:(jint)timeout {
  
#line 197
  [((DKActorRef *) nil_chk([this$0_ self__])) sendWithId:[[MTManagerActor_ConnectionDie alloc] initWithInt:val$id_]];
}

- (void)onMessage:(IOSByteArray *)data withOffset:(jint)offset withLen:(jint)len {
  
#line 202
  [((DKActorRef *) nil_chk([this$0_ self__])) sendWithId:[[MTManagerActor_InMessage alloc] initWithByteArray:data withInt:offset withInt:len]];
}


#line 206
- (void)onConnectionDie {
  
#line 207
  [((DKActorRef *) nil_chk([this$0_ self__])) sendWithId:[[MTManagerActor_ConnectionDie alloc] initWithInt:val$id_]];
}

- (instancetype)initWithMTManagerActor:(MTManagerActor *)outer$
                               withInt:(jint)capture$0 {
  this$0_ = outer$;
  val$id_ = capture$0;
  return [super init];
}

- (void)copyAllFieldsTo:(MTManagerActor_$2 *)other {
  [super copyAllFieldsTo:other];
  other->this$0_ = this$0_;
  other->val$id_ = val$id_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(MTManagerActor_$2)

@implementation MTManagerActor_$3

- (void)onConnectionCreated:(id<AMConnection>)connection {
  
#line 212
  [((DKActorRef *) nil_chk([this$0_ self__])) sendWithId:[[MTManagerActor_ConnectionCreated alloc] initWithInt:val$id_ withAMConnection:connection]];
}


#line 216
- (void)onConnectionCreateError {
  
#line 217
  [((DKActorRef *) nil_chk([this$0_ self__])) sendWithId:[[MTManagerActor_ConnectionCreateFailure alloc] init]];
}

- (instancetype)initWithMTManagerActor:(MTManagerActor *)outer$
                               withInt:(jint)capture$0 {
  this$0_ = outer$;
  val$id_ = capture$0;
  return [super init];
}

- (void)copyAllFieldsTo:(MTManagerActor_$3 *)other {
  [super copyAllFieldsTo:other];
  other->this$0_ = this$0_;
  other->val$id_ = val$id_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(MTManagerActor_$3)
