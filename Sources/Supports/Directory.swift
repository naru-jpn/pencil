//
//  Directory.swift
//  PencilExample
//
//  Created by naru on 2016/10/14.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension URL {

    public func append(path component: String, isDirectory: Bool = false) -> URL {
        return self.appendingPathComponent(component, isDirectory: isDirectory)
    }
}

/// Get url for some directory.
public class Directory {
    
    /// ~/Applications
    public static var Applications: URL? {
        do {
            return try FileManager.default.url(for: .applicationDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            debugPrint("Failed to get applications directory: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// ~/Applications/Demos
    public static var Demos: URL? {
        do {
            return try FileManager.default.url(for: .demoApplicationDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            debugPrint("Failed to get demos directory: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// ~/Library/Documentation
    public static var Documentation: URL? {
        do {
            return try FileManager.default.url(for: .documentationDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            debugPrint("Failed to get documentation directory: \(error.localizedDescription)")
            return nil
        }
    }

    /// ~/Documents
    public static var Documents: URL? {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            debugPrint("Failed to get documents directory: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// ~/Library/Autosave%20Information
    public static var AutosavedInformation: URL? {
        do {
            return try FileManager.default.url(for: .autosavedInformationDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            debugPrint("Failed to get autosaved directory: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// ~/Library/Caches
    public static var Caches: URL? {
        do {
            return try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            debugPrint("Failed to get caches directory: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// ~/Downloads
    public static var Downloads: URL? {
        do {
            return try FileManager.default.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            debugPrint("Failed to get downloads directory: \(error.localizedDescription)")
            return nil
        }
    }
}
