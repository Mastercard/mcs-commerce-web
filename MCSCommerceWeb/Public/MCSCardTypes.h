/* Copyright © 2019 Mastercard. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 =============================================================================*/

#import <Foundation/Foundation.h>

#ifndef MCSCardTypes_h
#define MCSCardTypes_h

/** enum definition for allowable card types **/
typedef NSString * MCSCardType NS_STRING_ENUM;
/** Mastercard card type **/
extern MCSCardType const MCSCardTypeMaster;
/** Visa card type **/
extern MCSCardType const MCSCardTypeVisa;
/** Diners Club card type **/
extern MCSCardType const MCSCardTypeDiners;
/** Discover card type **/
extern MCSCardType const MCSCardTypeDiscover;
/** JCB card type **/
extern MCSCardType const MCSCardTypeJcb;
/** China Union Pay card type **/
extern MCSCardType const MCSCardTypeCup;
/** American Express card type **/
extern MCSCardType const MCSCardTypeAmex;
/** Maestro card type **/
extern MCSCardType const MCSCardTypeMaestro;
/** Isracard card type **/
extern MCSCardType const MCSCardTypeIsracard;
/** Afterpay card type **/
extern MCSCardType const MCSCardTypeAfterpay;

#endif
