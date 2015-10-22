
#import "ComboBoxButton.h"

@implementation ComboBoxButton

@synthesize tableArray,btn,showRowCount;

-(id)initWithFrame:(CGRect)frame
{
    CGFloat frameWidth=frame.size.width;
    CGFloat frameHeight=frame.size.height;
    showRowCount=-1;
    
    self=[super initWithFrame:frame];
    
    if(self){
        showList = FALSE; //默认不显示下拉框
        
        tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, 0)];
        tv.delegate = self;
        tv.dataSource = self;
        tv.backgroundColor = [UIColor grayColor];
        tv.separatorColor = [UIColor lightGrayColor];
        tv.hidden = YES;
        [self addSubview:tv];
        
        UIImage *launcherImage=[UIImage imageNamed:@"area_btn"];
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:launcherImage forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(0, 0, frameWidth, frameHeight)];
        [btn addTarget:self action:@selector(onDropdownBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        
        btn.titleLabel.font= [UIFont systemFontOfSize: 15.0];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
        
        [self addSubview:btn];
    }
    return self;
}

- (void)onDropdownBtnClick: (id) sender {
    [btn resignFirstResponder];
    if (showList) {
        return;
    }else {//如果下拉框尚未显示，则进行显示
        
        CGRect sf = self.frame;
        sf.size.height = 180;
        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        [self bringSubviewToFront:btn];
        tv.hidden = NO;
        showList = YES;//显示下拉框
        
        CGRect frame = tv.frame;
        frame.size.height = 0;
        frame.origin.x=[btn frame].origin.x - [self frame].origin.x + 1;
        frame.origin.y=[btn bounds].size.height + 30;
        tv.frame = frame;
        //frame.size.height = [tableArray count] * 45;
        if (showRowCount==-1) {
            showRowCount=[tableArray count];
        }
        frame.size.height = showRowCount * 45;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        
        tv.frame = frame;
        [UIView commitAnimations];
    }
}

-(void)closeDropdown{
    showList = NO;
    tv.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = tv.frame;
    frame.size.height = 0;
    tv.frame = frame;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [btn setTitle:[tableArray objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
    
    [self closeDropdown];
    
    if ([self delegate] != Nil){
        [[self delegate] launch:[indexPath row]];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

