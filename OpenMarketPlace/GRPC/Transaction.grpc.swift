//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: Transaction.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import Dispatch
import Foundation
import SwiftGRPC
import SwiftProtobuf

internal protocol Transaction_TransactionprocessPaymentCall: ClientCallUnary {}

fileprivate final class Transaction_TransactionprocessPaymentCallBase: ClientCallUnaryBase<Transaction_PaymentRequest, Transaction_PaymentResult>, Transaction_TransactionprocessPaymentCall {
  override class var method: String { return "/transaction.Transaction/processPayment" }
}

internal protocol Transaction_TransactionprocessQueryCall: ClientCallUnary {}

fileprivate final class Transaction_TransactionprocessQueryCallBase: ClientCallUnaryBase<Transaction_QueryRequest, Transaction_QueryResult>, Transaction_TransactionprocessQueryCall {
  override class var method: String { return "/transaction.Transaction/processQuery" }
}

internal protocol Transaction_TransactionprocessRefundCall: ClientCallUnary {}

fileprivate final class Transaction_TransactionprocessRefundCallBase: ClientCallUnaryBase<Transaction_RefundRequest, Transaction_RefundResult>, Transaction_TransactionprocessRefundCall {
  override class var method: String { return "/transaction.Transaction/processRefund" }
}


/// Instantiate Transaction_TransactionServiceClient, then call methods of this protocol to make API calls.
internal protocol Transaction_TransactionService: ServiceClient {
  /// Synchronous. Unary.
  func processPayment(_ request: Transaction_PaymentRequest, metadata customMetadata: Metadata) throws -> Transaction_PaymentResult
  /// Asynchronous. Unary.
  @discardableResult
  func processPayment(_ request: Transaction_PaymentRequest, metadata customMetadata: Metadata, completion: @escaping (Transaction_PaymentResult?, CallResult) -> Void) throws -> Transaction_TransactionprocessPaymentCall

  /// Synchronous. Unary.
  func processQuery(_ request: Transaction_QueryRequest, metadata customMetadata: Metadata) throws -> Transaction_QueryResult
  /// Asynchronous. Unary.
  @discardableResult
  func processQuery(_ request: Transaction_QueryRequest, metadata customMetadata: Metadata, completion: @escaping (Transaction_QueryResult?, CallResult) -> Void) throws -> Transaction_TransactionprocessQueryCall

  /// Synchronous. Unary.
  func processRefund(_ request: Transaction_RefundRequest, metadata customMetadata: Metadata) throws -> Transaction_RefundResult
  /// Asynchronous. Unary.
  @discardableResult
  func processRefund(_ request: Transaction_RefundRequest, metadata customMetadata: Metadata, completion: @escaping (Transaction_RefundResult?, CallResult) -> Void) throws -> Transaction_TransactionprocessRefundCall

}

internal extension Transaction_TransactionService {
  /// Synchronous. Unary.
  func processPayment(_ request: Transaction_PaymentRequest) throws -> Transaction_PaymentResult {
    return try self.processPayment(request, metadata: self.metadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  func processPayment(_ request: Transaction_PaymentRequest, completion: @escaping (Transaction_PaymentResult?, CallResult) -> Void) throws -> Transaction_TransactionprocessPaymentCall {
    return try self.processPayment(request, metadata: self.metadata, completion: completion)
  }

  /// Synchronous. Unary.
  func processQuery(_ request: Transaction_QueryRequest) throws -> Transaction_QueryResult {
    return try self.processQuery(request, metadata: self.metadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  func processQuery(_ request: Transaction_QueryRequest, completion: @escaping (Transaction_QueryResult?, CallResult) -> Void) throws -> Transaction_TransactionprocessQueryCall {
    return try self.processQuery(request, metadata: self.metadata, completion: completion)
  }

  /// Synchronous. Unary.
  func processRefund(_ request: Transaction_RefundRequest) throws -> Transaction_RefundResult {
    return try self.processRefund(request, metadata: self.metadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  func processRefund(_ request: Transaction_RefundRequest, completion: @escaping (Transaction_RefundResult?, CallResult) -> Void) throws -> Transaction_TransactionprocessRefundCall {
    return try self.processRefund(request, metadata: self.metadata, completion: completion)
  }

}

internal final class Transaction_TransactionServiceClient: ServiceClientBase, Transaction_TransactionService {
  /// Synchronous. Unary.
  internal func processPayment(_ request: Transaction_PaymentRequest, metadata customMetadata: Metadata) throws -> Transaction_PaymentResult {
    return try Transaction_TransactionprocessPaymentCallBase(channel)
      .run(request: request, metadata: customMetadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  internal func processPayment(_ request: Transaction_PaymentRequest, metadata customMetadata: Metadata, completion: @escaping (Transaction_PaymentResult?, CallResult) -> Void) throws -> Transaction_TransactionprocessPaymentCall {
    return try Transaction_TransactionprocessPaymentCallBase(channel)
      .start(request: request, metadata: customMetadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func processQuery(_ request: Transaction_QueryRequest, metadata customMetadata: Metadata) throws -> Transaction_QueryResult {
    return try Transaction_TransactionprocessQueryCallBase(channel)
      .run(request: request, metadata: customMetadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  internal func processQuery(_ request: Transaction_QueryRequest, metadata customMetadata: Metadata, completion: @escaping (Transaction_QueryResult?, CallResult) -> Void) throws -> Transaction_TransactionprocessQueryCall {
    return try Transaction_TransactionprocessQueryCallBase(channel)
      .start(request: request, metadata: customMetadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func processRefund(_ request: Transaction_RefundRequest, metadata customMetadata: Metadata) throws -> Transaction_RefundResult {
    return try Transaction_TransactionprocessRefundCallBase(channel)
      .run(request: request, metadata: customMetadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  internal func processRefund(_ request: Transaction_RefundRequest, metadata customMetadata: Metadata, completion: @escaping (Transaction_RefundResult?, CallResult) -> Void) throws -> Transaction_TransactionprocessRefundCall {
    return try Transaction_TransactionprocessRefundCallBase(channel)
      .start(request: request, metadata: customMetadata, completion: completion)
  }

}

/// To build a server, implement a class that conforms to this protocol.
/// If one of the methods returning `ServerStatus?` returns nil,
/// it is expected that you have already returned a status to the client by means of `session.close`.
internal protocol Transaction_TransactionProvider: ServiceProvider {
  func processPayment(request: Transaction_PaymentRequest, session: Transaction_TransactionprocessPaymentSession) throws -> Transaction_PaymentResult
  func processQuery(request: Transaction_QueryRequest, session: Transaction_TransactionprocessQuerySession) throws -> Transaction_QueryResult
  func processRefund(request: Transaction_RefundRequest, session: Transaction_TransactionprocessRefundSession) throws -> Transaction_RefundResult
}

extension Transaction_TransactionProvider {
  internal var serviceName: String { return "transaction.Transaction" }

  /// Determines and calls the appropriate request handler, depending on the request's method.
  /// Throws `HandleMethodError.unknownMethod` for methods not handled by this service.
  internal func handleMethod(_ method: String, handler: Handler) throws -> ServerStatus? {
    switch method {
    case "/transaction.Transaction/processPayment":
      return try Transaction_TransactionprocessPaymentSessionBase(
        handler: handler,
        providerBlock: { try self.processPayment(request: $0, session: $1 as! Transaction_TransactionprocessPaymentSessionBase) })
          .run()
    case "/transaction.Transaction/processQuery":
      return try Transaction_TransactionprocessQuerySessionBase(
        handler: handler,
        providerBlock: { try self.processQuery(request: $0, session: $1 as! Transaction_TransactionprocessQuerySessionBase) })
          .run()
    case "/transaction.Transaction/processRefund":
      return try Transaction_TransactionprocessRefundSessionBase(
        handler: handler,
        providerBlock: { try self.processRefund(request: $0, session: $1 as! Transaction_TransactionprocessRefundSessionBase) })
          .run()
    default:
      throw HandleMethodError.unknownMethod
    }
  }
}

internal protocol Transaction_TransactionprocessPaymentSession: ServerSessionUnary {}

fileprivate final class Transaction_TransactionprocessPaymentSessionBase: ServerSessionUnaryBase<Transaction_PaymentRequest, Transaction_PaymentResult>, Transaction_TransactionprocessPaymentSession {}

internal protocol Transaction_TransactionprocessQuerySession: ServerSessionUnary {}

fileprivate final class Transaction_TransactionprocessQuerySessionBase: ServerSessionUnaryBase<Transaction_QueryRequest, Transaction_QueryResult>, Transaction_TransactionprocessQuerySession {}

internal protocol Transaction_TransactionprocessRefundSession: ServerSessionUnary {}

fileprivate final class Transaction_TransactionprocessRefundSessionBase: ServerSessionUnaryBase<Transaction_RefundRequest, Transaction_RefundResult>, Transaction_TransactionprocessRefundSession {}

