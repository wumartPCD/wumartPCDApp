
#import <Foundation/Foundation.h>

#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/xmlstring.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>

#import "GDataDefines.h"

@class NSArray, NSDictionary, NSError, NSString, NSURL;
@class GDataXMLElement, GDataXMLDocument;

enum {
  GDataXMLInvalidKind = 0,
  GDataXMLDocumentKind,
  GDataXMLElementKind,
  GDataXMLAttributeKind,
  GDataXMLNamespaceKind,
  GDataXMLProcessingInstructionKind,
  GDataXMLCommentKind,
  GDataXMLTextKind,
  GDataXMLDTDKind,
  GDataXMLEntityDeclarationKind,
  GDataXMLAttributeDeclarationKind,
  GDataXMLElementDeclarationKind,
  GDataXMLNotationDeclarationKind
};

typedef NSUInteger GDataXMLNodeKind;

@interface GDataXMLNode : NSObject {
@protected
  
  xmlNodePtr xmlNode_; // may also be an xmlAttrPtr or xmlNsPtr
  BOOL shouldFreeXMLNode_; // if yes, xmlNode_ will be free'd in dealloc
  
  // cached values
  NSString *cachedName_;
  NSArray *cachedChildren_;
  NSArray *cachedAttributes_;
}

+ (GDataXMLElement *)elementWithName:(NSString *)name;
+ (GDataXMLElement *)elementWithName:(NSString *)name stringValue:(NSString *)value;
+ (GDataXMLElement *)elementWithName:(NSString *)name URI:(NSString *)value;

+ (id)attributeWithName:(NSString *)name stringValue:(NSString *)value;
+ (id)attributeWithName:(NSString *)name URI:(NSString *)attributeURI stringValue:(NSString *)value;

+ (id)namespaceWithName:(NSString *)name stringValue:(NSString *)value;

+ (id)textWithStringValue:(NSString *)value;

- (NSString *)stringValue;
- (void)setStringValue:(NSString *)str;

- (NSUInteger)childCount;
- (NSArray *)children;
- (GDataXMLNode *)childAtIndex:(unsigned)index;

- (NSString *)localName;
- (NSString *)name;
- (NSString *)prefix;
- (NSString *)URI;

- (GDataXMLNodeKind)kind;

- (NSString *)XMLString;

+ (NSString *)localNameForName:(NSString *)name;
+ (NSString *)prefixForName:(NSString *)name;

- (NSArray *)nodesForXPath:(NSString *)xpath error:(NSError **)error;

@end

@interface GDataXMLElement : GDataXMLNode {
}

- (id)initWithXMLString:(NSString *)str error:(NSError **)error;

- (NSArray *)namespaces;
- (void)setNamespaces:(NSArray *)namespaces;
- (void)addNamespace:(GDataXMLNode *)aNamespace;

- (void)addChild:(GDataXMLNode *)child;

- (NSArray *)elementsForName:(NSString *)name;
- (NSArray *)elementsForLocalName:(NSString *)localName URI:(NSString *)URI;

- (NSArray *)attributes;
- (GDataXMLNode *)attributeForName:(NSString *)name;
- (GDataXMLNode *)attributeForLocalName:(NSString *)name URI:(NSString *)attributeURI;
- (void)addAttribute:(GDataXMLNode *)attribute;

- (NSString *)resolvePrefixForNamespaceURI:(NSString *)namespaceURI;

@end

@interface GDataXMLDocument : NSObject {
@protected
  xmlDoc* xmlDoc_; 
}

- (id)initWithXMLString:(NSString *)str options:(unsigned int)mask error:(NSError **)error;
- (id)initWithData:(NSData *)data options:(unsigned int)mask error:(NSError **)error;
- (id)initWithRootElement:(GDataXMLElement *)element;

- (GDataXMLElement *)rootElement;

- (NSData *)XMLData;

- (void)setVersion:(NSString *)version;
- (void)setCharacterEncoding:(NSString *)encoding;

- (NSArray *)nodesForXPath:(NSString *)xpath error:(NSError **)error;

- (NSString *)description;
@end
