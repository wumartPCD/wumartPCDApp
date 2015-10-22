
#import <TargetConditionals.h>

// Define later OS versions when building on earlier versions
#ifndef MAC_OS_X_VERSION_10_5
  #define MAC_OS_X_VERSION_10_5 1050
#endif
#ifndef MAC_OS_X_VERSION_10_6
  #define MAC_OS_X_VERSION_10_6 1060
#endif


#ifdef GDATA_TARGET_NAMESPACE
// prefix all GData class names with GDATA_TARGET_NAMESPACE for this target
  #import "GDataTargetNamespace.h"
#endif

#if TARGET_OS_IPHONE // iPhone SDK

  #define GDATA_IPHONE 1

#endif

#if GDATA_IPHONE

  #define GDATA_FOUNDATION_ONLY 1

  #define GDATA_USES_LIBXML 1

  #import "GDataXMLNode.h"

  #define NSXMLDocument                  GDataXMLDocument
  #define NSXMLElement                   GDataXMLElement
  #define NSXMLNode                      GDataXMLNode
  #define NSXMLNodeKind                  GDataXMLNodeKind
  #define NSXMLInvalidKind               GDataXMLInvalidKind
  #define NSXMLDocumentKind              GDataXMLDocumentKind
  #define NSXMLElementKind               GDataXMLElementKind
  #define NSXMLAttributeKind             GDataXMLAttributeKind
  #define NSXMLNamespaceKind             GDataXMLNamespaceKind
  #define NSXMLProcessingInstructionKind GDataXMLDocumentKind
  #define NSXMLCommentKind               GDataXMLCommentKind
  #define NSXMLTextKind                  GDataXMLTextKind
  #define NSXMLDTDKind                   GDataXMLDTDKind
  #define NSXMLEntityDeclarationKind     GDataXMLEntityDeclarationKind
  #define NSXMLAttributeDeclarationKind  GDataXMLAttributeDeclarationKind
  #define NSXMLElementDeclarationKind    GDataXMLElementDeclarationKind
  #define NSXMLNotationDeclarationKind   GDataXMLNotationDeclarationKind

  // properties used for retaining the XML tree in the classes that use them
  #define kGDataXMLDocumentPropertyKey @"_XMLDocument"
  #define kGDataXMLElementPropertyKey  @"_XMLElement"
#endif

#ifndef GDATA_ASSERT
  // we directly invoke the NSAssert handler so we can pass on the varargs
  #if !defined(NS_BLOCK_ASSERTIONS)
    #define GDATA_ASSERT(condition, ...)                                       \
      do {                                                                     \
        if (!(condition)) {                                                    \
          [[NSAssertionHandler currentHandler]                                 \
              handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
                                 file:[NSString stringWithUTF8String:__FILE__] \
                           lineNumber:__LINE__                                 \
                          description:__VA_ARGS__];                            \
        }                                                                      \
      } while(0)
  #else
    #define GDATA_ASSERT(condition, ...) do { } while (0)
  #endif // !defined(NS_BLOCK_ASSERTIONS)
#endif // GDATA_ASSERT

#ifndef GDATA_DEBUG_ASSERT
  #if DEBUG
    #define GDATA_DEBUG_ASSERT(condition, ...) GDATA_ASSERT(condition, __VA_ARGS__)
  #else
    #define GDATA_DEBUG_ASSERT(condition, ...) do { } while (0)
  #endif
#endif

#ifndef GDATA_DEBUG_LOG
  #if DEBUG
    #define GDATA_DEBUG_LOG(...) NSLog(__VA_ARGS__)
  #else
    #define GDATA_DEBUG_LOG(...) do { } while (0)
  #endif
#endif

#ifndef GDATA_FOREACH
  #if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_5)
    #define GDATA_FOREACH(element, collection) \
      for (element in collection)
    #define GDATA_FOREACH_KEY(key, dict) \
      for (key in dict)
  #else
    #define GDATA_FOREACH(element, collection) \
      for (NSEnumerator* _ ## element ## _enum = [collection objectEnumerator]; \
          (element = [_ ## element ## _enum nextObject]) != nil; )
    #define GDATA_FOREACH_KEY(key, dict) \
      for (NSEnumerator* _ ## key ## _enum = [dict keyEnumerator]; \
          (key = [_ ## key ## _enum nextObject]) != nil; )
  #endif
#endif

#ifndef GDATA_SIMPLE_DESCRIPTIONS
  #if GDATA_IPHONE && !DEBUG
    #define GDATA_SIMPLE_DESCRIPTIONS 1
  #else
    #define GDATA_SIMPLE_DESCRIPTIONS 0
  #endif
#endif

#ifndef STRIP_GDATA_FETCH_LOGGING
  #if GDATA_IPHONE && !DEBUG
    #define STRIP_GDATA_FETCH_LOGGING 1
  #else
    #define STRIP_GDATA_FETCH_LOGGING 0
  #endif
#endif

#if MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_4
  // NSInteger/NSUInteger and Max/Mins
  #ifndef NSINTEGER_DEFINED
    #if __LP64__ || NS_BUILD_32_LIKE_64
      typedef long NSInteger;
      typedef unsigned long NSUInteger;
    #else
      typedef int NSInteger;
      typedef unsigned int NSUInteger;
    #endif
    #define NSIntegerMax    LONG_MAX
    #define NSIntegerMin    LONG_MIN
    #define NSUIntegerMax   ULONG_MAX
    #define NSINTEGER_DEFINED 1
  #endif  // NSINTEGER_DEFINED
#endif  // MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_4
