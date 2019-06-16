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

import Foundation

/// Base presenter, has the common method implementations for all presenters
class BasePresenter {
    
    /// Gets a string from the given table and key
    ///
    /// - Parameters:
    ///   - key: key to get the string
    ///   - table: table from where to get the string
    /// - Returns: String with the message
    func localizedString(forKey key: String, fromTable table:String) -> String {
        return Bundle.main.localizedString(forKey: key, value: nil, table: table)
    }
}
